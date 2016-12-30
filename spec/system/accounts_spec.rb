require 'spec_helper'

feature 'Buckets' do
  context 'when logged in as a user with a budget' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:budget) { FactoryGirl.create(:budget, user: user) }
    let(:bucket) { FactoryGirl.create(:bucket, budget: budget) }

    before :each do
      login_as user
    end

    scenario 'I can view the page for a bucket' do
      visit bucket_path(bucket)
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
      expect(bucket.amount).to eq(1000.0)
      expect(bucket.balance).to eq(-100.0)
    end
  end
end
