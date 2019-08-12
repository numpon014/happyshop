class Category < ApplicationRecord
  # belongs_to :parent, :class_name => Category
  # has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  has_many :products, :dependent => :destroy

  validates_presence_of :name
end
