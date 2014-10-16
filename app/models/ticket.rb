# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  customer_name  :string(255)
#  customer_email :string(255)
#  department     :string(255)
#  subject        :string(255)
#  description    :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reference      :
#  status         :string(255)      default("Waiting for Staff Response")
#  url            :string(255)
#

class Ticket < ActiveRecord::Base
  attr_accessible :customer_email, :customer_name, :department, :description, :subject, :reference, :status, :user_id, :response
  belongs_to :user

  def self.status
    ["Waiting for Staff Response", "Waiting for Customer",
                 "On Hold","Cancelled","Completed"]
  end


  before_create :default_values
  after_create :add_reference_to_url, :deliver_ticket_email

  def add_reference_to_url
    update_attribute(:url, self.url + "/" + self.reference )
  end

  def deliver_ticket_email
    begin
      CustomerMailer.ticket_email(self).deliver
    rescue Net::SMTPAuthenticationError
      logger.error "No email sent, please configure config/email.yml"
    rescue ArgumentError
      logger.error "No email sent, please give some arguments, empty strings"
    end
  end



  def self.search(search)
    if search
      find(:all, :conditions => ['subject LIKE ? or reference LIKE ? or description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end



  validates :customer_name, presence: true
  validates_email_format_of :customer_email, :message => 'is not looking good'
  validates :status, inclusion: { in: self.status,
                                    message: "This is not a valid status" }
  validates_uniqueness_of :reference

  private
    require 'securerandom'
    def default_values
      begin
        @ref = ""
        2.times {@ref += ((0...3).map { (65 + rand(26)).chr }.join) + "-" +  (SecureRandom.hex 1).upcase + '-'   }
        @ref += (0...3).map { (65 + rand(26)).chr }.join
        self.reference = @ref
      end while self.class.exists?(reference: reference)
    end

end
