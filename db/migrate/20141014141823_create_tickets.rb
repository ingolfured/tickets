class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_name, default: ""
      t.string :customer_email, default: ""
      t.string :department, default: ""
      t.string :subject, default: ""
      t.string :reference, default: ""
      t.text :description, default: ""

      t.timestamps
    end
  end
end
