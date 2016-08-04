class HomeController < ApplicationController

    def index
        @auctionOnline = Auction.joins(:product).where("auctions.auction_close > ? and auctions.status = ? ", Time.now,true).limit(10).order('created_at DESC')
        @auctionClosed  = Auction.joins(:product).where("auctions.auction_close < ?", Time.now).limit(10).order('created_at DESC')
        @auctionComing = Auction.joins(:product).where("auctions.auction_close > ? and auctions.status = ? ", Time.now,false).limit(10).order('created_at DESC')

    end
end
