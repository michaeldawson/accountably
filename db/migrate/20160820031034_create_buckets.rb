class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.references :budget, index: true, foreign_key: true
      t.string :name
      t.integer :amount

      t.timestamps null: false
    end
  end
end
