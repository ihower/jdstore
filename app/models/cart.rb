class Cart < ApplicationRecord

   has_many :cart_items
   has_many :products, through: :cart_items, source: :product

   def clean!
     cart_items.destroy_all
   end
   
   def add_product_to_cart(product)
     ci = cart_items.build
     ci.product = product
     ci.quantity = 1
     ci.save
   end

   def total_price
     cart_items.map{ |ci| ci.quantity * ci.product.price.to_i }.sum
   end

end
