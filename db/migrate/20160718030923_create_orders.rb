class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :reference
      t.text :designation
      t.decimal :unit_price_ht
      t.integer :quantity
      t.decimal :total_ht
      t.decimal :total_ttc
      t.timestamp :created_at
      t.timestamp :updated_at
      t.string :status
      t.string :payment_method
      t.user :belongs_to

      t.timestamps null: false
    end
  end
end
