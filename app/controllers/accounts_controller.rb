class AccountsController < ApplicationController
  before_action :authenticate_user!

  def create
    if account.save
      flash[:success] = 'Account created'
      redirect_to account_path(account)
    else
      flash[:error] = 'Nope'
      render :new
    end
  end

  private

  helper_method :accounts
  def accounts
    @accounts ||= current_user.accounts
  end

  helper_method :account
  def account
    @account ||= Account.find(params[:id]) if params.key?(:id)
    @account ||= Account.new(account_params)
  end

  def account_params
    default_account_params.merge(submitted_account_params) if params.key?(:account)
  end

  def submitted_account_params
    params.require(:account).permit(:name)
  end

  def default_account_params
    { user: current_user }
  end
end
