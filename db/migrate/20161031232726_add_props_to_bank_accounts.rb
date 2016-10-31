class AddPropsToBankAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :bank_accounts, :last_reconciled, :datetime
    add_column :bank_accounts, :balance, :integer
  end
end
