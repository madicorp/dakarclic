class ConfirmController < ApplicationController
    def index
        token = params[:token]
        invoice = Paydunya::Checkout::Invoice.new
        if invoice.confirm(token)

            puts invoice.status
        end
    end
end
