class CustomerMailer < ActionMailer::Base

  def ticket_email(ticket)
    @ticket = ticket
    mail(
      to:  @ticket.customer_email,
      from:      Rails.configuration.email[:name] + "<" + Rails.configuration.email[:email_address] + ">",
      subject:  "Your ticket has been successfully created",
      body:      "Dear " + @ticket.customer_name + "\n\nYour ticket number " +
      @ticket.reference + " has been successfully created. You can access it here: " + @ticket.url
    )
  end
end
