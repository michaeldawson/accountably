class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :bucket, index: true, foreign_key: true
      t.string :description
      t.datetime :occurred_at
      t.integer :amount

      t.timestamps null: false
    end
  end
end
