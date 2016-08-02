require 'paypal-sdk-rest'
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # # GET /orders
  # # GET /orders.json
  # def index
  #   @orders = Order.all
  # end
  #
  # # GET /orders/1
  # # GET /orders/1.json
  # def show
  # end

  # GET /orders/new
  def new

    @order = Order.new
    @order.quantity = params[:qte] unless params[:qte].nil?
    @order.total_ttc = params[:total] unless params[:total].nil?
    @order.total_ht = @order.total_ttc - params[:tva].to_s.to_d unless params[:total].nil? && params[:tva].nil?
  end

  # GET /orders/1/edit
  # def edit
  # end

  def create
    p order_params
    @order = Order.new order_params
    @order.status= "Pending"
    if @order.save
      case @order.payment_method
        when "paydunya"
          invoice = Paydunya::Checkout::Invoice.new
          invoice.add_item("Unités DakarClick", @order.quantity, @order.total_ht, @order.total_ttc)
          invoice.add_tax("TVA (18%)", @order.total_ht)
          invoice.total_amount = @order.total_ttc
          invoice.add_custom_data("units",@order.quantity)
          invoice.add_custom_data("orderid",@order.id)

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
        when "card"
          card = card_params
          p  '%.2f' % @order.total_ht
          # ###Payment
          # A Payment Resource; create one using
          # the above types and intent as `sale or `authorize`
          @payment = PayPal::SDK::REST::Payment.new({
                                     :intent => "sale",

                                     # ###Payer
                                     # A resource representing a Payer that funds a payment
                                     # Use the List of `FundingInstrument` and the Payment Method
                                     # as 'credit_card'
                                     :payer => {
                                         :payment_method => "credit_card",

                                         # ###FundingInstrument
                                         # A resource representing a Payeer's funding instrument.
                                         # Use a Payer ID (A unique identifier of the payer generated
                                         # and provided by the facilitator. This is required when
                                         # creating or using a tokenized funding instrument)
                                         # and the `CreditCardDetails`
                                         :funding_instruments => [{

                                                                      # ###CreditCard
                                                                      # A resource representing a credit card that can be
                                                                      # used to fund a payment.
                                                                      :credit_card => {
                                                                          :type => card[:type],
                                                                          :number => card[:number].tr(" ", ""),
                                                                          :expire_month => card[:month],
                                                                          :expire_year => card[:year],
                                                                          :cvv2 => card[:cvc],
                                                                          :first_name => card[:firstname],
                                                                          :last_name => card[:lastname],
                                                                      }
                                                                  }]
                                     },
                                     # ###Transaction
                                     # A transaction defines the contract of a
                                     # payment - what is the payment for and who
                                     # is fulfilling it.
                                     :transactions =>  [{

                                                            # Item List
                                                            :item_list => {
                                                                :items => [{
                                                                               :name => "credit",
                                                                               :sku => "credit",
                                                                               :price => "100.00",
                                                                               :currency => "EUR",
                                                                               :quantity => @order.quantity
                                                                           }]
                                                            },

                                                            # ###Amount
                                                            # Let's you specify a payment amount.
                                                            :amount =>  {
                                                                :total =>  '%.2f' % @order.total_ht,
                                                                :currency =>  "EUR" },
                                                            :description =>  "This is the payment transaction description."
                                                        }]
                                 })

          # Create Payment and return status( true or false )
          if @payment.create
            p "Payment[#{@payment.id}] created successfully"
          else
            # Display Error message
            p "Error while creating payment:"
            p @payment.error.inspect
          end
          redirect_to root_path
        when "paypal"
          @payment = PayPal::SDK::REST::Payment.new({
                                     :intent =>  "sale",

                                     # ###Payer
                                     # A resource representing a Payer that funds a payment
                                     # Payment Method as 'paypal'
                                     :payer =>  {
                                         :payment_method =>  "paypal" },

                                     # ###Redirect URLs
                                     :redirect_urls => {
                                         :return_url => "http://localhost:3000/confirm/paypal",
                                         :cancel_url => "http://localhost:3000/confirm/paypal" },

                                     # ###Transaction
                                     # A transaction defines the contract of a
                                     # payment - what is the payment for and who
                                     # is fulfilling it.
                                     :transactions =>  [{

                                                            # Item List
                                                            :item_list => {
                                                                :items => [{
                                                                               :name => "credit",
                                                                               :sku => "credit",
                                                                               :price => "100",
                                                                               :currency => "EUR",
                                                                               :quantity => @order.quantity
                                                                           }]
                                                            },

                                                            # ###Amount
                                                            # Let's you specify a payment amount.
                                                            :amount =>  {
                                                                :total =>  @order.total_ht,
                                                                :currency =>  "EUR" },
                                                            :description =>  "This is the payment transaction description."
                                                        }]
                                 })

          # Create Payment and return status
          if @payment.create
            # Redirect the user to given approval url
            @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
            redirect_to @redirect_url.to_s.split(": ").last.tr("\"","")
            p "Payment[#{@payment.id}]"
            p "Redirect: #{@redirect_url}"
          else
            p @payment.error.inspect
          end
        else
          redirect_to root_path
      end
    end

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    # params.fetch(:order, {})
    params.require(:order).permit(:quantity, :total_ttc ,:total_ht, :payment_method)
  end
  def card_params
    params.require(:card).permit(:number, :firstname, :lastname ,:month, :year, :cvc, :type)
  end
end
