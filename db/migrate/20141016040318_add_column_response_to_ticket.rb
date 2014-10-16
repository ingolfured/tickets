class AddColumnResponseToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :response, :text
  end
end
