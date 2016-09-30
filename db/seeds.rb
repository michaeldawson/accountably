user = User.create!(email: 'email.michaeldawson@gmail.com', password: 'testtest')
budget = Budget.create!(
  user: user,
  cycle_length: 'fortnightly',
  first_pay_day: Time.current.to_date,
  accounts: [
    Account.new(
      name: 'Rent',
      amount: '850.0',
    ),
    Account.new(
      name: 'Groceries',
      amount: '200.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'COLES 7842 COLLINGWOO'),
      ],
    ),
    Account.new(
      name: 'Cafes and Restaurants',
      amount: '200.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'LOVING HUT PTY LTD RICHMOND'),
        TransactionPattern.new(pattern: 'THE HOLY BEAN ROSEBUD'),
        TransactionPattern.new(pattern: 'MISS CHU SM PTY LTD SOUTH MELB'),
        TransactionPattern.new(pattern: 'TRIPPY TACO FITZROY'),
        TransactionPattern.new(pattern: 'BRASSERIE BREAD CO P SOUTH MELBOUR'),
        TransactionPattern.new(pattern: 'SUSHI CHEF MELBOURNE'),
        TransactionPattern.new(pattern: 'TU GUAI BAO PTY LTD SOUTH YARR'),
      ],
    ),
    Account.new(
      name: 'Home and funiture',
      amount: '100.0',
    ),
    Account.new(
      name: 'Long-term savings',
      amount: '500.0',
    ),
    Account.new(
      name: 'Travel',
      amount: '250.0',
    ),
    Account.new(
      name: 'Short-term savings',
      amount: '100.0',
    ),
    Account.new(
      name: 'Gifts',
      amount: '50.0',
    ),
    Account.new(
      name: 'Health and gym',
      amount: '200.0',
    ),
    Account.new(
      name: 'Rent',
      amount: '850.0',
    ),
    Account.new(
      name: 'Auto registration and insurance',
      amount: '50.0',
    ),
    Account.new(
      name: 'Electricity and Gas',
      amount: '40.0',
    ),
    Account.new(
      name: 'Water',
      amount: '10.0',
    ),
    Account.new(
      name: 'Internet and phone',
      amount: '60.0',
    ),
    Account.new(
      name: 'Memberships',
      amount: '25.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'UPCASE FROM THOUGHTBOT'),
      ],
    ),
    Account.new(
      name: 'Uncategorised',
      amount: '0.0',
    ),
    Account.new(
      name: 'Public transport',
      amount: '35.0',
    ),
    Account.new(
      name: 'Cycling',
      amount: '20.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'CBD CYCLES MELBOURNE'),
        TransactionPattern.new(pattern: 'STAR CYCLE PTY LTD'),
      ],
    ),
    Account.new(
      name: 'Taxis',
      amount: '20.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'BLACK CAB VIC'),
      ],
    ),
    Account.new(
      name: 'ATM Cash Out',
      amount: '50.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'NABATM CSH'),
      ],
    ),
    Account.new(
      name: 'Bank Fees',
      amount: '5.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'FOREIGN CURRENCY TRAN FEE'),
      ],
    ),
    Account.new(
      name: 'Automotive',
      amount: '50.0',
    ),
    Account.new(
      name: 'Entertainment',
      amount: '50.0',
    ),
  ]
)

user_id = ENV['BANK_ACCOUNT_USER_ID']
password = ENV['BANK_ACCOUNT_PASSWORD']
if [user_id, password].all?(&:present?)
  credentials = { user_id: user_id, password: password }
  login = Bank::Login.create!(budget: budget, credentials: credentials, adapter_type: 'NAB')
  Bank::Account.create!(login: login, name: 'Spending')
  Bank::Account.create!(login: login, name: 'Personal Account #3490')
end
