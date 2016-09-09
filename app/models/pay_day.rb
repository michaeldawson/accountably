class PayDay < ActiveRecord::Base
  belongs_to :budget

  validates :budget, presence: true
  validates :effective_date, presence: true

  after_create :apply!
  def apply!
    Transaction.transaction do
      budget.accounts.each do |account|
        payday_transaction(account).save!
      end
    end
  end

  private

  def payday_transaction(account)
    Transaction::Income.new(
      account: account,
      description: 'payday',
      amount: account.amount,
      effective_date: effective_date
    )
  end
end
