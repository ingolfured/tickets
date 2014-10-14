class DropTableCustomers < ActiveRecord::Migration
  def up
    drop_table :customers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
