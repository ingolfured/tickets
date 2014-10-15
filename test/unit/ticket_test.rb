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

require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
