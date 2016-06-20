class RemoveEndsAtToAuctions < ActiveRecord::Migration
    def change
        remove_column :auctions, :ends_at
    end
end
