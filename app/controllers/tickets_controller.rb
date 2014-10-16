class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.json

  def customer
    if current_user.nil?
      @ticket = Ticket.new
      render "customer"
    else
      redirect_to list_new_path
    end
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
    if params[:ticket][:user]
      @ticket.user = current_user
    end
    @ticket.url = request.original_url
    respond_to do |format|
      if @ticket.save
        flash[:notice] = "The ticket was successfully created"
        format.html { redirect_to root_path, notice: 'Ticket was successfully created, our team will now take a look at it.' }
      else
        flash[:error] = "An error occurred"
        format.html { render action: "customer" }
      end
    end
  end

  def index
    @tickets = Ticket.search(params[:search])
    authorize @tickets.first unless @tickets.first.nil?
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find_by_reference(params[:id])
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end


  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])
    if params[:ticket][:user_id][0]
      @ticket.user = current_user
    end

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        unless @ticket.response.nil?
          begin
            CustomerMailer.response_email(@ticket).deliver
          rescue Net::SMTPAuthenticationError
            logger.error "No email sent, please configure config/email.yml"
          rescue ArgumentError
            logger.error "No email sent, please give some arguments, empty strings"
          end
        end
        format.html { redirect_to ticket_path(@ticket.reference), notice: 'Ticket was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    authorize @ticket
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  def list_new
    @tickets = Ticket.where("status = 'Waiting for Staff Response'")
    authorize @tickets.first unless @tickets.first.nil?
    render "index"
  end
  def list_open
    @tickets = Ticket.all - Ticket.where(["status = '%s' or status = '%s'", "Cancelled", "Completed"])
    authorize @tickets.first unless @tickets.first.nil?
    render "index"
  end
  def list_onhold
    @tickets = Ticket.where("status = 'On Hold'")
    authorize @tickets.first unless @tickets.first.nil?
    render "index"
  end
  def list_closed
    @tickets = Ticket.where(["status = '%s' or status = '%s'", "Cancelled", "Completed"])
    authorize @tickets.first unless @tickets.first.nil?
    render "index"
  end
end
