class Ticket < ActiveRecord::Base
  attr_accessible :customer_email, :customer_name, :department, :description, :subject
end
