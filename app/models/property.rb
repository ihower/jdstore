class Property < ApplicationRecord

	has_many :property_ships
	has_many :products, :through => :property_ships

end
