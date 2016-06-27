class HomeController < ApplicationController

    def index
            @productsOnline= Product.joins(:auction).where("auctions.auction_close > ?", Time.now)
    end
end
