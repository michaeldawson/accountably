# Generated using lib/tasks/seeds.rake
user = User.create!(email: 'email.michaeldawson@gmail.com', password: 'testtest')
budget = Budget.create!(
  user: user,
  cycle_length: 'fortnightly',
  first_pay_day: Date.parse('2016-11-02'),
  buckets: [
    Bucket.new(
      name: 'Cafes and Restaurants',
      amount: '1212.0',
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
        TransactionPattern.new(pattern: 'KROU SUPAN THAI REST SOUTH MELB'),
        TransactionPattern.new(pattern: 'YING THAI II PTY LTD'),
        TransactionPattern.new(pattern: 'Shakahari At Clarendo South Melb'),
        TransactionPattern.new(pattern: 'FRIENDS OF THE EARTH COLLINGWOO'),
        TransactionPattern.new(pattern: 'SKYHIGH MT DANDENONG'),
        TransactionPattern.new(pattern: 'SMITH AND DAUGHTERS FITZROY'),
        TransactionPattern.new(pattern: 'SPUDBAR OPERATING SY RICHMOND'),
        TransactionPattern.new(pattern: 'V0064 30/09 MYER MELBOURNE CITY MELBOURNE 74564456274 MISCELLANEOUS DEBIT'),
        TransactionPattern.new(pattern: 'WHITE KIMCHI FITZROY'),
        TransactionPattern.new(pattern: 'V0064 29/10 THE ORGNC FOOD & W D MELBOURNE 74564506305 MISCELLANEOUS DEBIT'),
      ],
    ),
    Bucket.new(
      name: 'Home and funiture',
      amount: '100.0',
    ),
    Bucket.new(
      name: 'Long-term savings',
      amount: '500.0',
    ),
    Bucket.new(
      name: 'Travel',
      amount: '200.0',
    ),
    Bucket.new(
      name: 'Short-term savings',
      amount: '100.0',
    ),
    Bucket.new(
      name: 'Gifts',
      amount: '40.0',
    ),
    Bucket.new(
      name: 'Health and gym',
      amount: '140.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'AUSFIT ANYTIME F'),
        TransactionPattern.new(pattern: 'V0064 12/10 EB *The Gut-Mind Conne'),
        TransactionPattern.new(pattern: 'Personal training'),
      ],
    ),
    Bucket.new(
      name: 'Auto registration and insurance',
      amount: '50.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'VICROADS ONLINE PAYMENT'),
      ],
    ),
    Bucket.new(
      name: 'Electricity and Gas',
      amount: '30.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'ORIGINENERGY LTD AUTOMATIC DRAWING'),
      ],
    ),
    Bucket.new(
      name: 'Water',
      amount: '5.0',
    ),
    Bucket.new(
      name: 'Internet and phone',
      amount: '50.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'AMAYSIM AUSTRALIA LIMITEDSYDNEY'),
        TransactionPattern.new(pattern: 'TPG Internet'),
      ],
    ),
    Bucket.new(
      name: 'Memberships',
      amount: '25.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'UPCASE FROM THOUGHTBOT'),
        TransactionPattern.new(pattern: 'ADELAIDE UNI GLIDING CLUBADELAIDE'),
        TransactionPattern.new(pattern: 'ADOBE PHOTOGPHY PLAN'),
      ],
    ),
    Bucket.new(
      name: 'Public transport',
      amount: '20.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'V0064 14/09 7-ELEVEN 1053 FITZROY 74564456259 MISCELLANEOUS DEBIT'),
        TransactionPattern.new(pattern: 'V0064 31/08 7-ELEVEN 1211 DOCKLANDS 74564456244 MISCELLANEOUS DEBIT'),
        TransactionPattern.new(pattern: 'V0064 29/09 7-ELEVEN 1053 FITZROY 74564456274 MISCELLANEOUS DEBIT'),
      ],
    ),
    Bucket.new(
      name: 'Taxis',
      amount: '20.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'BLACK CAB VIC'),
        TransactionPattern.new(pattern: 'SKYBUS COACH SERVICE MELBOURNE'),
        TransactionPattern.new(pattern: 'WWW.INGOGO MASCOT'),
        TransactionPattern.new(pattern: 'GM CABS PTY. LTD. MASCOT'),
      ],
    ),
    Bucket.new(
      name: 'ATM Cash Out',
      amount: '50.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'NABATM CSH'),
        TransactionPattern.new(pattern: 'ATM DEBIT'),
      ],
    ),
    Bucket.new(
      name: 'Bank Fees',
      amount: '5.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'FOREIGN CURRENCY TRAN FEE'),
        TransactionPattern.new(pattern: 'ATM FEES'),
        TransactionPattern.new(pattern: 'CARD PAYMENT FEE ATO SYDNEY'),
      ],
    ),
    Bucket.new(
      name: 'Automotive',
      amount: '40.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'STAR CYCLE PTY LTD'),
        TransactionPattern.new(pattern: 'PETER STEVENS MOTORCYCLESMELBOURNE'),
      ],
    ),
    Bucket.new(
      name: 'Entertainment',
      amount: '1110.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'SPOTIFY AUSTRALIA PL SURRY HILL'),
        TransactionPattern.new(pattern: 'HONEY BIRDETTE RUNDLE MALADELAIDE'),
        TransactionPattern.new(pattern: 'NETFLIX COM MELBOURNE'),
        TransactionPattern.new(pattern: 'Jazz Party-Rock n'),
      ],
    ),
    Bucket.new(
      name: 'Petrol',
      amount: '10.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'BP BELAIR'),
        TransactionPattern.new(pattern: 'BABCO PETROLEUM STH MELBOU'),
        TransactionPattern.new(pattern: 'LIBERTY FITZROY FITZROY'),
      ],
    ),
    Bucket.new(
      name: 'Clothes',
      amount: '30.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'MYER ADELAIDE CITY ADELAIDE'),
        TransactionPattern.new(pattern: 'CLEAR IT FITZROY'),
        TransactionPattern.new(pattern: 'AUSTRALIAN RED CROSS COLLINGWOO'),
      ],
    ),
    Bucket.new(
      name: 'Income Tax',
      amount: '0.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'ATO AUTOMATIC DRAWING'),
        TransactionPattern.new(pattern: 'ATO PAYMENT SYDNEY'),
      ],
    ),
    Bucket.new(
      name: 'Alcohol',
      amount: '20.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'V/CELLARS'),
      ],
    ),
    Bucket.new(
      name: 'Servers',
      amount: '12.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'DIGITALOCEAN.COM'),
        TransactionPattern.new(pattern: 'Amazon web services aws.amazon'),
      ],
    ),
    Bucket.new(
      name: 'Cycling',
      amount: '10.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'CBD CYCLES MELBOURNE'),
        TransactionPattern.new(pattern: 'J222228LWV37S PAYPAL AUSTRALIA AUTOMATIC DRAWING'),
      ],
    ),
    Bucket.new(
      name: 'Donations',
      amount: '10.0',
      transaction_patterns: [
        TransactionPattern.new(pattern: 'V0064 06/10 ONE GIRL AUSTRALIA COLLINGWOO'),
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
