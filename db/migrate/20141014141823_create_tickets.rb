class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_name
      t.string :customer_email
      t.string :department
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
