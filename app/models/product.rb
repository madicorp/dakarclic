class Product < ActiveRecord::Base
    has_many :auction
    has_attached_file :image
    validates_attachment :image,
                         content_type: { content_type: ["image/jpeg", "image/jpg","image/gif", "image/png"] }
    def has_auction?
        auction.present?
    end

end
