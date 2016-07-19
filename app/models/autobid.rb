class AutoBid < ActiveRecord::Base
    belongs_to :user
    belongs_to :auction

    validates_numericality_of :max_bid
end
