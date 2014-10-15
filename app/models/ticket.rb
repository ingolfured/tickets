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
#  reference      :string(255)
#

class Ticket < ActiveRecord::Base
  attr_accessible :customer_email, :customer_name, :department, :description, :subject, :reference

  before_create :default_values
  after_create :deliver_ticket_email

  def deliver_ticket_email
    begin
      CustomerMailer.ticket_email(self).deliver
    rescue Net::SMTPAuthenticationError
      logger.error "No email sent, please configure config/email.yml"
    rescue ArgumentError
      logger.error "No email sent, please give some arguments, empty strings"
    end
  end


  validates :customer_name, presence: true
  validates_email_format_of :customer_email, :message => 'is not looking good'

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
