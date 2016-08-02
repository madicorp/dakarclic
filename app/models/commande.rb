class Commande < ActiveRecord::Base
  belongs_to :user

  def total
    unit_price_ht * quantity
  end
end
