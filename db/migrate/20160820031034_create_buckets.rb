class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.references :budget, index: true, foreign_key: true
      t.string :name
      t.integer :amount, null: false, default: 0
      t.integer :balance, null: false, default: 0
      t.boolean :default, null: false, default: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_index :buckets, :deleted_at
  end
end
