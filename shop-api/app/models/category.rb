class Category < ApplicationRecord
  # belongs_to :parent, :class_name => Category
  # has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  # has_many :products, :dependent => :destroy
  has_and_belongs_to_many :products

  before_destroy { products.clear }

  validates_presence_of :name
end
