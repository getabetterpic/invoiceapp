class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  def index
    if params[:invoice_header_id]
		@payments = Payment.where(:invoice_header_id => params[:invoice_header_id])
	else
		@payments = Payment.all
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @invoice_header = InvoiceHeader.find(params[:invoice_header_id])
    @payment = @invoice_header.payments.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @invoice_header = InvoiceHeader.find(params[:invoice_header_id])
    @payment = @invoice_header.payments.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    @invoice_header = InvoiceHeader.find(params[:invoice_header_id])
    @payment = @invoice_header.payments.new(params[:payment])

    respond_to do |format|
      if @payment.save
        format.html { redirect_to invoice_payments_path(params[:invoice_header_id]), :notice => 'Payment was successfully created.' }
        format.json { render :json => @payment, :status => :created, :location => @payment }
      else
        format.html { render :action => "new" }
        format.json { render :json => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    @invoice_header = InvoiceHeader.find(params[:invoice_header_id])
    @payment = @invoice_header.payments.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to invoice_payments_path(params[:invoice_header_id]), :notice => 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @invoice_header = InvoiceHeader.find(params[:invoice_header_id])
    @payment = @invoice_header.payments.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to invoice_payments_url }
      format.json { head :no_content }
    end
  end
end
