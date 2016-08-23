require 'spec_helper'

feature 'Buckets' do
  context 'when logged in as a user with a budget' do
    before :each do
      @user = FactoryGirl.create(:user)
      @budget = FactoryGirl.create(:budget, buckets: [Bucket.new(name: 'Things')])
      login_as @user
    end

    scenario 'I can view the page for a bucket' do
      visit budget_path(@budget)
      click_on 'Things'
      expect(page).to have_css('h1.bucket')
    end
  end
end
