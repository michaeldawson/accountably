class TransactionsController < ApplicationController
  def initialize(*args)
    raise "Can't directly instantiate a transactions controller" if self.class == TransactionsController
    super(*args)
  end

  def create
    transaction_params.merge!(source: current_user)

    if transaction.save
      flash[:notice] = 'Transaction was saved'
      redirect_to transaction.bucket
    else
      flash[:error] = "Sorry, that didn't work."
      redirect_to request.referrer || root_path
    end
  end

  def update
    if transaction.update(transaction_params)
      flash[:notice] = 'Transaction was updated'
      redirect_to transaction.bucket
    else
      flash[:error] = "Sorry, that didn't work."
      render 'edit'
    end
  end

  def destroy
    if transaction.destroy
      flash[:notice] = 'Transaction was deleted'
      redirect_to transaction.bucket
    else
      flash[:error] = "Sorry, that didn't work"
      redirect_to edit_transaction_path(transaction)
    end
  end

  private

  def transaction_params
    @transaction_params ||= params.require(:transaction).permit(*permitted_attributes).to_h if params.key?(:transaction)
  end

  def permitted_attributes
    [:bucket_id, :amount, :description, :effective_date]
  end
end
