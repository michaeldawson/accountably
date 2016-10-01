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
        TransactionPattern.new(pattern: 'COLES 0448 ST PETERS'),
        TransactionPattern.new(pattern: 'COLES'),
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
        TransactionPattern.new(pattern: 'JO SUSHI SOUTH MELBOUR'),
        TransactionPattern.new(pattern: 'HUXTABURGER & BILLS COLLINGWOO'),
        TransactionPattern.new(pattern: 'SHOPHOUSE RAMEN FITZROY'),
        TransactionPattern.new(pattern: 'YOCHI FROZEN YOGHURT CARLTON'),
        TransactionPattern.new(pattern: 'SHAKAHARI VEGETARIAN'),
        TransactionPattern.new(pattern: 'LONG STORY SHORT CAFE PTYRICHMOND'),
        TransactionPattern.new(pattern: 'Mr Goodbar Adelaide'),
        TransactionPattern.new(pattern: 'ARGO ON THE PARADE NORWOOD'),
        TransactionPattern.new(pattern: 'FRANCESCOS CICCHHETTI SEACLIFF'),
        TransactionPattern.new(pattern: 'LOTUS LOUNGE ADELAIDE'),
        TransactionPattern.new(pattern: 'BREAD BONE WOOD GR ADELAIDE'),
        TransactionPattern.new(pattern: 'LET THEM EAT ADELAIDE'),
        TransactionPattern.new(pattern: 'EAT NOW SERVICES PL MULGRAVE'),
        TransactionPattern.new(pattern: 'ITAMI MARION PTY LTD OAKLANDS'),
      ],
    ),
    Account.new(
      name: 'Home and funiture',
      amount: '100.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'OUTSTANDING TRANS #4017-9540-6225-0064 MISCELLANEOUS DEBIT'),
      ],
    ),
    Account.new(
      name: 'Long-term savings',
      amount: '500.0',
    ),
    Account.new(
      name: 'Travel',
      amount: '200.0',
    ),
    Account.new(
      name: 'Short-term savings',
      amount: '150.0',
    ),
    Account.new(
      name: 'Gifts',
      amount: '40.0',
    ),
    Account.new(
      name: 'Health and gym',
      amount: '140.0',
    ),
    Account.new(
      name: 'Auto registration and insurance',
      amount: '50.0',
    ),
    Account.new(
      name: 'Electricity and Gas',
      amount: '30.0',
    ),
    Account.new(
      name: 'Water',
      amount: '5.0',
    ),
    Account.new(
      name: 'Internet and phone',
      amount: '60.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'AMAYSIM AUSTRALIA LIMITEDSYDNEY'),
      ],
    ),
    Account.new(
      name: 'Memberships',
      amount: '25.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'UPCASE FROM THOUGHTBOT'),
        TransactionPattern.new(pattern: 'ADELAIDE UNI GLIDING CLUBADELAIDE'),
      ],
    ),
    Account.new(
      name: 'Uncategorised',
      amount: '0.0',
    ),
    Account.new(
      name: 'Public transport',
      amount: '30.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'V0064 14/09 7-ELEVEN 1053 FITZROY 74564456259 MISCELLANEOUS DEBIT'),
        TransactionPattern.new(pattern: 'V0064 31/08 7-ELEVEN 1211 DOCKLANDS 74564456244 MISCELLANEOUS DEBIT'),
      ],
    ),
    Account.new(
      name: 'Taxis',
      amount: '20.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'BLACK CAB VIC'),
        TransactionPattern.new(pattern: 'SKYBUS COACH SERVICE MELBOURNE'),
        TransactionPattern.new(pattern: 'WWW.INGOGO MASCOT'),
      ],
    ),
    Account.new(
      name: 'ATM Cash Out',
      amount: '50.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'NABATM CSH'),
        TransactionPattern.new(pattern: 'ATM DEBIT'),
      ],
    ),
    Account.new(
      name: 'Bank Fees',
      amount: '5.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'FOREIGN CURRENCY TRAN FEE'),
        TransactionPattern.new(pattern: 'ATM FEES'),
      ],
    ),
    Account.new(
      name: 'Automotive',
      amount: '40.0',
    ),
    Account.new(
      name: 'Entertainment',
      amount: '40.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'SPOTIFY AUSTRALIA PL SURRY HILL'),
        TransactionPattern.new(pattern: 'HONEY BIRDETTE RUNDLE MALADELAIDE'),
      ],
    ),
    Account.new(
      name: 'Petrol',
      amount: '10.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'BP BELAIR'),
      ],
    ),
    Account.new(
      name: 'Clothes',
      amount: '30.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'MYER ADELAIDE CITY ADELAIDE'),
      ],
    ),
    Account.new(
      name: 'Income Tax',
      amount: '0.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'ATO AUTOMATIC DRAWING'),
      ],
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
