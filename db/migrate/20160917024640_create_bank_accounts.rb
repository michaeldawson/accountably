class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.references :budget, index: true, foreign_key: true
      t.string :name
      t.datetime :sync_from
      t.string :adapter_type

      t.timestamps null: false
    end
  end
end
