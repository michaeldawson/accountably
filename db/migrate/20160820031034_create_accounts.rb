class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :budget, index: true, foreign_key: true
      t.string :name
      t.integer :amount
      t.integer :balance, default: 0
      t.boolean :default, null: false, default: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_index :accounts, :deleted_at
  end
end
