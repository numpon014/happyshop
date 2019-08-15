class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  validates_presence_of :name, :price, :sku, :stock

  scope :by_price, -> (from, to) { where("price >= ? AND price <= ?", from.to_i, to.to_i) }
  scope :sold_out, -> { where(stock: 0) }

  mount_uploader :image, ProductImageUploader

  before_destroy { categories.clear }
end
