class Product < ActiveRecord::Base
    has_one :auction

    def has_auction?
        auction.present?
    end

end
