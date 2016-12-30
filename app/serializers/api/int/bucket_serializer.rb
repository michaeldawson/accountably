module API
  module Int
    class BucketSerializer < ActiveModel::Serializer
      attributes :id, :name, :amount
    end
  end
end
