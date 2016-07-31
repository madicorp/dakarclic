class HomeController < ApplicationController

    def index
            @auctionOnline= Auction.where("auctions.auction_close > ?", Time.now)
    end
end
