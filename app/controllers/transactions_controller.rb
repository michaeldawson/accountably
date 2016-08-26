class TransactionsController < ApplicationController
  def create
    transaction.amount *= -1

    if transaction.save
      flash[:notice] = 'Transaction was saved'
      redirect_to transaction.bucket
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
    params.require(:transaction).permit(:bucket_id, :amount, :description) if params.key?(:transaction)
  end
end
