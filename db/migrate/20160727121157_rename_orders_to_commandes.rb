class RenameOrdersToCommandes < ActiveRecord::Migration
    def change
        rename_table :orders, :commandes
    end
end
