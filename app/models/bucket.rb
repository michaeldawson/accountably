class Bucket < ActiveRecord::Base
  belongs_to :budget

  validates :budget, presence: true
end
