class Transaction::Expense < Transaction
  def effective_amount
    amount.to_i.abs * -1
  end
end
