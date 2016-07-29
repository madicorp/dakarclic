class AddLinkPdfToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :linkpdf, :string
  end
end
