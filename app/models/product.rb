class Product < ApplicationRecord

  mount_uploader :image, ImageUploader

  belongs_to :category, :optional => true

	has_many :property_ships
	has_many :properties, :through => :property_ships
	
end
