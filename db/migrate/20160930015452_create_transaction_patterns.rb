class CreateTransactionPatterns < ActiveRecord::Migration[5.0]
  def change
    create_table :transaction_patterns do |t|
      t.references :account, foreign_key: true
      t.string :pattern

      t.timestamps
    end
  end
end
