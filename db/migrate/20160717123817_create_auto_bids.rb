class CreateAutoBids < ActiveRecord::Migration
  def change
    create_table :auto_bids do |t|
      t.references :user, index: true, foreign_key: true
      t.references :auction, index: true, foreign_key: true
      t.integer :max_bid
    end
  end
end
