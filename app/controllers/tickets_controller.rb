class TicketsController < ApplicationController
  before_filter :confirm_logged_in,  :except => [:new]

  def index
    @tickets = Ticket.all
    @statuses = Status.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
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

=begin
  def process(arg)
    puts  arg.inspect
    #@ticket = Ticket.find(params[:id])
    #@statuses = Status.all
  end
=end

  # POST /tickets
  # POST /tickets.json
  def create
    email = params[:ticket][:email]

    user = Customer.find_by_email(email)

    if user.nil?
      name = params[:ticket][:name]
      user = Customer.new({email: email, name: name})
      user.save
    end

    @ticket = Ticket.new(
        {
          :title       => params[:ticket][:title],
          :description => params[:ticket][:description],
          :reference   => get_reference(),
          :customer_id => user.id,
          :status_id   => 1
        }
    )

    respond_to do |format|
      if @ticket.save
        status = 'Ticket was successfully created.'
        UserMailer.ticket_notification(user, @ticket).deliver

        format.html { redirect_to @ticket, notice:  status}
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
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

  private
  def get_reference()
    id = Ticket.last ? Ticket.last.id : 0
    number = 12345 + id
    return "ABC-"+number.to_s
  end
end
