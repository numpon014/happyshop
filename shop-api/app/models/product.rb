class Product < ApplicationRecord
  belongs_to :category

  validates_presence_of :name, :price, :sku, :stock

  mount_uploader :image, ProductImageUploader
end
