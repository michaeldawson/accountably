require 'spec_helper'

feature 'Budgets', js: true do
  describe 'setup' do
    context 'when logged in as a user' do
      let!(:user) { FactoryGirl.create(:user) }
      before { login_as user }

      describe 'Step 1' do
        context 'without a budget' do
          scenario 'I can set up a budget, with a defined cycle length, and a pay day.' do
            payday = Time.current.to_date

            visit root_path

            expect(page).to have_css('.mt-step-col.done', text: 'BASICS')

            select 'weekly', from: 'Cycle length'
            fill_in 'Total amount', with: 100
            fill_in 'First pay day', with: payday.strftime('%d/%m/%Y')

            click_on 'Next'

            expect(page).to have_css('.mt-step-col.done', text: 'BANK INTEGRATION')

            budget = Budget.last

            expect(budget.user).to eq(user)
            expect(budget.target).to eq(100.0)
            expect(budget.first_pay_day).to eq(payday)
          end
        end
      end

      describe 'Step 2' do
        context 'with a budget' do
          let!(:budget) { FactoryGirl.create(:budget, user: user) }

          scenario 'I can setup a bank login' do
            visit edit_budget_path
            expect(page).to have_css('.mt-step-col.done', text: 'BANK INTEGRATION')

            fill_in 'Customer ID', with: '12345678'
            fill_in 'Password', with: 'abc123'

            expect {
              click_on 'Next'
              expect(page).to have_css('.mt-step-col.done', text: 'BUCKETS')
            }.to change {
              Bank::Login.count
            }.by(1)
          end

          context 'when I already have a bank login' do
            let!(:login) { FactoryGirl.create(:bank_login, budget: budget) }

            scenario 'I can modify my bank login details' do
              visit edit_budget_path
              click_on 'Bank Integration'
              fill_in 'Customer ID', with: '87654321'
              fill_in 'Password', with: '123abc'

              expect {
                click_on 'Next'
                expect(page).to have_css('.mt-step-col.done', text: 'BUCKETS')
              }.to change {
                login.reload.credentials
              }.to(user_id: '87654321', password: '123abc')
            end
          end
        end
      end

      describe 'Step 3' do
        context 'with a budget with buckets' do
          let!(:budget) { FactoryGirl.create(:budget, user: user) }
          let!(:bank_account) { FactoryGirl.create(:bank_account, budget: budget) }
          let!(:bucket) { FactoryGirl.create(:bucket, name: 'Rent', budget: budget) }

          scenario 'I can delete the bucket' do
            visit edit_budget_path
            expect(page).to have_css('.mt-step-col.done', text: 'BUCKETS')

            expect {
              find('.ion-ios-close-outline').click
              expect(page).not_to have_content('Rent')
            }.to change {
              budget.buckets.count
            }.from(1).to(0)
          end
        end
      end
    end
  end
end
