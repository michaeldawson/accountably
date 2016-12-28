module API
  module Int
    class AccountSerializer < ActiveModel::Serializer
      attributes :id, :name, :amount
    end
  end
end
