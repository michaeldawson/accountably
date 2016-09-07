class TransactionsController < ApplicationController
  def create
    transaction.amount *= -1 if transaction.valid?

    if transaction.save
      flash[:notice] = 'Transaction was saved'
      redirect_to transaction.account
    else
      flash[:error] = "Sorry, that didn't work."
      redirect_to request.referrer || root_path
    end
  end

  private

  def transaction
    @transaction ||= Transaction.new(transaction_params)
  end

  def transaction_params
    params.require(:transaction).permit(*permitted_transaction_attributes) if params.key?(:transaction)
  end

  def permitted_transaction_attributes
    [:account_id, :amount, :description, :effective_date]
  end
end
