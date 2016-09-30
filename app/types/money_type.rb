# Internally, money is always represented as cents (integer). Then it is cast into a Money object which renders nicely
# to a string, etc.
require 'money'

class MoneyType < ActiveRecord::Type::Value
  def cast(value)
    Money.new(value)
  end

  def deserialize(value)
    Money.new(value)
  end

  def serialize(value)
    super(Money.new(value).cents)
  end
end
