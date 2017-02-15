class CartItem < ApplicationRecord

  belongs_to :cart
  belongs_to :product

  belongs_to :foobar, :class_name => "Product", :foreign_key => "product_id"
  
end
