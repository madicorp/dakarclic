require 'open-uri'

class ConfirmController < ApplicationController
    def index
        token = params[:token]
        invoice = Paydunya::Checkout::Invoice.new
        if invoice.confirm(token)
            if invoice.status.eql? 'completed'
                unit = invoice.get_custom_data("units")
                total_ht = invoice.get_custom_data("total_ht")

                user = current_user
                user.units += unit.to_i
                commande = Commande.new
                commande.quantity = unit
                commande.total_ht = total_ht
                commande.total_ttc = invoice.total_amount
                commande.user = user
                commande.linkpdf = invoice.receipt_url

                ActiveRecord::Base.transaction do
                    commande.save
                    user.save
                end

            #     url = invoice.receipt_url
            #     data = open(url).read
            #     send_data data, :disposition => 'application/pdf', :filename=>"Confirmation.pdf"
            end
        end
    end
end
