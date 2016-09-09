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

  def update
    if transaction.update(transaction_params)
      flash[:notice] = 'Transaction was updated'
      redirect_to transaction.account
    else
      flash[:error] = "Sorry, that didn't work."
      render 'edit'
    end
  end

  def destroy
    if transaction.destroy
      flash[:notice] = 'Transaction was deleted'
      redirect_to transaction.account
    else
      flash[:error] = "Sorry, that didn't work"
      redirect_to edit_transaction_path(transaction)
    end
  end

  private

  helper_method :transaction
  def transaction
    @transaction ||= Transaction.find(params[:id]) if params.key?(:id)
    @transaction ||= Transaction.new(transaction_params)
  end

  def transaction_params
    params.require(:transaction).permit(*permitted_transaction_attributes) if params.key?(:transaction)
  end

  def permitted_transaction_attributes
    [:account_id, :amount, :description, :effective_date]
  end
end
