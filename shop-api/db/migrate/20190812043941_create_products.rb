class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.string :image
      t.string :description
      t.string :price
      t.integer :stock, default: 1

      t.timestamps
    end
  end
end
