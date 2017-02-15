class Order < ApplicationRecord

  belongs_to :user
  has_many :product_lists

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  before_create :generate_token

  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end

  def pay!
    self.update_columns(paid_at: Time.now)
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

end
