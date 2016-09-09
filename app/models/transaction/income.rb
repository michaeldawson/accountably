class Transaction::Income < Transaction
  def effective_amount
    amount.to_i.abs
  end
end
