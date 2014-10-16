class AddColumnUrlToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :url, :string
  end
end
