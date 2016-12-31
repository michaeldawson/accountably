class ApplicationController < ActionController::Base
  include Concerns::LayoutOptions

  protect_from_forgery with: :exception

  def require_current_budget
    redirect_to new_budget_path unless current_budget
  end

  helper_method def current_budget
    current_user.budget
  end
end
