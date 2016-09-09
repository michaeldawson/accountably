require 'spec_helper'

feature 'Transactions' do
  before :each do
    @budget = FactoryGirl.create(
      :budget,
      accounts: [
        FactoryGirl.create(:account, name: 'Things', amount: 100)
      ]
    )
    @user = FactoryGirl.create(:user)
    login_as @user
  end

  let(:account) { @budget.accounts.first }

  scenario 'I can add transactions to a account' do
    visit account_path(account)
    fill_in 'Description', with: 'A new transaction'
    fill_in 'Amount', with: 100

    expect {
      click_on 'Save'
      expect(page).to have_content 'Transaction was saved'
    }.to change {
      account.reload.balance
    }.by(-100)
  end

  context 'when a account has transactions' do
    before :each do
      @transaction = FactoryGirl.create(:transaction, account: account, description: 'Something wot I bought')
    end

    scenario "I can see them on the account's page" do
      visit account_path(account)
      expect(page).to have_content(@transaction.description)
    end

    scenario 'I can edit their description, effective date and amount', js: true do
      new_date = Time.current.to_date.tomorrow
      new_description = 'A new description'
      new_amount = 100

      visit account_path(account)

      within '.account-transactions' do
        within find('tr', text: @transaction.description) do
          find('i.ion-edit').click
        end
      end

      fill_in 'Date', with: new_date.strftime('%d/%m/%Y')
      find('body').click
      fill_in 'Description', with: new_description
      fill_in 'Amount', with: new_amount

      click_on 'Save'
      expect(page).to have_content('Transaction was updated')

      @transaction.reload
      expect(@transaction.effective_date).to eq(new_date)
      expect(@transaction.description).to eq(new_description)
      expect(@transaction.amount).to eq(new_amount)
    end

    scenario 'I can delete the transaction', js: true do
      visit edit_transaction_path(@transaction)

      expect {
        find('i.ion-ios-close-outline').click
        expect(page).to have_content('Transaction was deleted')
      }.to change {
        Transaction.count
      }.by(-1)
    end
  end
end
