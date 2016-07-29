require "paypal-sdk-rest"
include PayPal::SDK::REST
class CommandesController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # # GET /orders
  # # GET /orders.json
  def index
    commandes = Commande.all
  end
  #
  # # GET /orders/1
  # # GET /orders/1.json
  # def show
  # end

  # GET /orders/new
  def new

    @commande = Commande.new
    @commande.quantity = params[:qte] unless params[:qte].nil?
    @commande.total_ttc = params[:total] unless params[:total].nil?
    @commande.total_ht = @commande.total_ttc - params[:tva].to_s.to_d unless params[:total].nil? && params[:tva].nil?
  end

  # GET /orders/1/edit
  # def edit
  # end

  def create
     # @order = Order.new(order_params)
      orderdunya

    # respond_to do |format|
    #   if @order.save
    #     format.html { redirect_to @order, notice: 'Order was successfully created.' }
    #     format.json { render :show, status: :created, location: @order }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # # PATCH/PUT /orders/1
  # # PATCH/PUT /orders/1.json
  # def update
  #   respond_to do |format|
  #     if @order.update(order_params)
  #       format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @order }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /orders/1
  # # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def orderpaypal
      @payment = Payment.new({
     :intent => "sale",
     :payer => {
         :payment_method => "credit_card",
         :funding_instruments => [{
                                      :credit_card => {
                                          :type => "visa",
                                          :number => "4567516310777851",
                                          :expire_month => "11",
                                          :expire_year => "2018",
                                          :cvv2 => "874",
                                          :first_name => "Joe",
                                          :last_name => "Shopper",
                                          :billing_address => {
                                              :line1 => "52 N Main ST",
                                              :city => "Johnstown",
                                              :state => "OH",
                                              :postal_code => "43210",
                                              :country_code => "US" }}}]},
     :transactions => [{
                           :item_list => {
                               :items => [{
                                              :name => "item",
                                              :sku => "item",
                                              :price => "1",
                                              :currency => "USD",
                                              :quantity => 1 }]},
                           :amount => {
                               :total => "1.00",
                               :currency => "USD" },
                           :description => "This is the payment transaction description." }]})


      # Create Payment and return the status(true or false)
      if @payment.create
          @payment.id     # Payment Id
      else
          @payment.error  # Error Hash
      end
  end

  def orderdunya
      invoice = Paydunya::Checkout::Invoice.new
      commande = Commande.new(order_params)
      invoice.add_item("Unités DakarClick", commande.quantity, commande.total_ht, commande.total_ttc)
      invoice.add_tax("TVA (18%)", commande.total_ht)
      invoice.total_amount = commande.total_ttc
      invoice.add_custom_data("units", commande.quantity)
      invoice.add_custom_data("total_ht", commande.total_ht)
      if invoice.create
          puts invoice.status
          puts invoice.response_text
          # Vous pouvez par exemple faire un "redirect_to invoice.invoice_url"
          redirect_to  invoice.invoice_url
          puts invoice.invoice_url
      else
          puts invoice.status
          puts invoice.response_text
      end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      commande = Commande.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      # params.fetch(:order, {})
        params.require(:commande).permit(:quantity, :total_ttc , :total_ht)
    end
end
