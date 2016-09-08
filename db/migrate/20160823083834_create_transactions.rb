class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :account, index: true, foreign_key: true
      t.references :source, index: true, polymorphic: true
      t.string :description
      t.datetime :effective_date
      t.integer :amount

      t.timestamps null: false
    end
  end
end
