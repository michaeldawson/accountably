class CreatePayDays < ActiveRecord::Migration
  def change
    create_table :pay_days do |t|
      t.references :budget, index: true, foreign_key: true
      t.date :effective_date

      t.timestamps null: false
    end
  end
end
