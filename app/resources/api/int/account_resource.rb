module Api
  module Int
    class AccountResource < JSONAPI::Resource
      attributes :name

      class << self
        def records(options = {})
          current_user = options[:context][:current_user]
          return Account.none unless current_user&.budget.present?
          current_user.budget.accounts
        end
      end
    end
  end
end
