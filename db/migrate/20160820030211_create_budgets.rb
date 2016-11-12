class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :target
      t.date :first_pay_day
      t.string :cycle_length

      t.timestamps null: false
    end
  end
end
