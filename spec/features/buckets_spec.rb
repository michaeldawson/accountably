require 'spec_helper'

feature 'Buckets' do
  context 'when logged in as a user with a budget' do
    before :each do
      @budget = FactoryGirl.create(
        :budget,
        buckets: [
          FactoryGirl.create(:bucket, name: 'Things', amount: 100)
        ]
      )
      login_as (@user = FactoryGirl.create(:user))
    end

    let(:bucket) { @budget.buckets.first }

    scenario 'I can view the page for a bucket' do
      visit budget_path(@budget)
      click_on 'Things'
      expect(page).to have_css('h3.bucket')
    end

    scenario 'I can edit a bucket' do
      visit edit_bucket_path(bucket)
      fill_in 'Name', with: 'A new name'
      fill_in 'Amount', with: 1000
      fill_in 'Balance', with: -100

      click_on 'Save'
      expect(page).to have_content('Bucket was updated')
      bucket.reload

      expect(bucket.name).to eq('A new name')
      expect(bucket.amount).to eq(1000)
      expect(bucket.balance).to eq(-100)
    end

    scenario 'I can add transactions to a bucket' do
      visit bucket_path(bucket)
      fill_in 'Description', with: 'A new transaction'
      fill_in 'Amount', with: 100

      expect {
        click_on 'Save'
        expect(page).to have_content 'Transaction was saved'
      }.to change {
        bucket.reload.balance
      }.by(-100)
    end
  end
end
