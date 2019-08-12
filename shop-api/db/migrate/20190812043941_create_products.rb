class CreateProducts < ActiveRecord::Migration[5.2]
  def up
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.string :image
      t.string :description
      t.string :price
      t.integer :stock, default: 1
      t.references :category, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :products
  end
end
