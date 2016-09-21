class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.references :login, index: true, foreign_key: true
      t.string :name
      t.datetime :sync_from

      t.timestamps null: false
    end
  end
end
