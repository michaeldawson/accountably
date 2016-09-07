user = User.create!(email: 'email.michaeldawson@gmail.com', password: 'testtest')
Budget.create!(
  user: user,
  cycle_length: 'fortnightly',
  first_pay_day: Time.current.to_date,
  # Salary $2788.50
  accounts: [
    Account.new(name: 'Rent', amount: 850),
    Account.new(name: 'Tax bill', amount: 300),
    Account.new(name: 'Groceries', amount: 200),
    Account.new(name: 'Cafes and Restaurants', amount: 200),
    Account.new(name: 'Home and funiture', amount: 100),
    Account.new(name: 'Long-term savings', amount: 500),
    Account.new(name: 'Travel', amount: 250),
    Account.new(name: 'Short-term savings', amount: 100),
    Account.new(name: 'Gifts', amount: 50),
    Account.new(name: 'Health and gym', amount: 200),
    Account.new(name: 'Rent', amount: 850),
    Account.new(name: 'Auto insurance', amount: 50),
    Account.new(name: 'Electricity and Gas', amount: 40),
    Account.new(name: 'Water', amount: 10),
    Account.new(name: 'Internet and phone', amount: 60),
    Account.new(name: 'Memberships', amount: 25),
  ]
)
