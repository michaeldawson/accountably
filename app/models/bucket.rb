class Bucket < ActiveRecord::Base
  belongs_to :budget, inverse_of: :buckets

  validates :budget, presence: true
end
