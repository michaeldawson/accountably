require 'spec_helper'

feature 'Transactions' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:budget) { FactoryGirl.create(:budget, user: user, buckets: [bucket]) }
  let(:bucket) { FactoryGirl.build(:bucket, name: 'Things', amount: 100) }

  before :each do
    login_as user
  end

  scenario 'I can add transactions to a bucket', js: true do
    visit bucket_path(bucket)
    fill_in 'Description', with: 'A new transaction'
    fill_in 'Amount', with: 100

    expect {
      click_on 'Save'
      expect(page).to have_content 'Transaction was saved'
    }.to change {
      bucket.reload.balance
    }.by(-100.0)
  end

  context 'when a bucket has expenses' do
    let!(:transaction) { FactoryGirl.create(:expense_transaction, bucket: bucket, description: 'Something') }

    scenario "I can see them on the bucket's page" do
      visit bucket_path(bucket)
      expect(page).to have_content(transaction.description)
    end

    scenario 'I can edit their description, effective date and amount', js: true do
      new_date = Time.current.to_date.tomorrow
      new_description = 'A new description'
      new_amount = 100.0

      visit bucket_path(bucket)

      within '.bucket-transactions' do
        within find('tr', text: transaction.description) do
          find('i.ion-edit').click
        end
      end

      fill_in 'Date', with: new_date.strftime('%d/%m/%Y')
      find('body').click
      fill_in 'Description', with: new_description
      fill_in 'Amount', with: new_amount

      click_on 'Save'
      expect(page).to have_content('Transaction was updated')

      transaction.reload
      expect(transaction.effective_date).to eq(new_date)
      expect(transaction.description).to eq(new_description)
      expect(transaction.amount).to eq(new_amount)
    end

    scenario 'I can delete the transaction', js: true do
      visit edit_transaction_expense_path(transaction)

      expect {
        find('i.ion-ios-close-outline').click
        expect(page).to have_content('Transaction was deleted')
      }.to change {
        Transaction.count
      }.by(-1)
    end
  end
end
