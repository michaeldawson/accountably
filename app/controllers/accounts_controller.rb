class AccountsController < ApplicationController
  def update
    if account.update(account_attributes)
      flash[:notice] = 'Account was updated'
      redirect_to account
    else
      flash[:error] = "Sorry, that didn't work"
      render 'edit'
    end
  end

  private

  helper_method :account
  def account
    @account ||= Account.find(params[:id])
  end

  def account_attributes
    params.require(:account).permit(:name, :amount, :balance)
  end

  helper_method :transaction
  def transaction
    @transaction ||= Transaction.new(effective_date: Time.current.to_date)
  end
end
