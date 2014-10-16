class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.json

  def customer
    @ticket = Ticket.new
    render "customer"
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
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
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find_by_reference(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end


  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to :back, notice: 'Ticket was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
