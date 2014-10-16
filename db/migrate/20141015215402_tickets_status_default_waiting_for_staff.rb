class TicketsStatusDefaultWaitingForStaff < ActiveRecord::Migration
  def change
    change_column :tickets, :status, :string, default: "Waiting for Staff Response"
  end

end
