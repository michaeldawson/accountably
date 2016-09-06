require 'spec_helper'

feature 'Transactions' do
  before :each do
    @budget = FactoryGirl.create(
      :budget,
      buckets: [
        FactoryGirl.create(:bucket, name: 'Things', amount: 100)
      ]
    )
    @user = FactoryGirl.create(:user)
    login_as @user
  end

  let(:bucket) { @budget.buckets.first }

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

  context 'when a bucket has transactions' do
    before :each do
      @transaction = FactoryGirl.create(:transaction, bucket: bucket, description: 'Something wot I bought')
    end

    scenario "I can see them on the bucket's page" do
      visit bucket_path(bucket)
      expect(page).to have_content(@transaction.description)
    end
  end
end
