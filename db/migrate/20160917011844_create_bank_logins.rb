class CreateBankLogins < ActiveRecord::Migration
  def change
    create_table :bank_logins do |t|
      t.references :budget, index: true
      t.binary :credentials
      t.string :adapter_type

      t.timestamps null: false
    end
  end
end
