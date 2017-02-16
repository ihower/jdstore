namespace :dev do

  task :fake => [:fake_products, :fake_users, :fake_orders]

  task :fake_products => :environment do
    10.times do
      Product.create!( :title => Faker::Commerce.product_name,
                       :description => Faker::Lorem.paragraph,
                       :quantity => rand(100),
                       :price => ( rand(100)+1 ) * 10 )
    end
  end

  task :fake_users => :environment do
    10.times do
      User.create!( :email => Faker::Internet.email, :password => "12345678")
    end
  end

  task :fake_orders => :environment do
    users = User.all
    products = Product.all

    100.times do
      order = Order.new(
        :user => users.sample,
        :billing_name => Faker::Name.name,
        :billing_address => Faker::Address.street_address,
        :shipping_name => Faker::Name.name,
        :shipping_address => Faker::Address.street_address,
      )

      products.sample( rand(3)+1 ).each do |p|
        order.product_lists.build( :product_name => p.title,
                                   :product_price => p.price,
                                   :quantity => rand(5)+1,
                                 )
      end

      order.total = order.product_lists.map{ |p| p.product_price * p.quantity }.sum
      order.created_at = Time.now - (rand(100)+1) * 3600
      order.save!
    end


    %w[ paid shipping shipped order_cancelled good_returned ].each do |state|
      Order.all.sample(10).each do |o|
        o.update_columns( :aasm_state => state,
                          :is_paid => [true, false].sample,
                          :payment_method => ["alipay", "wechat"].sample )
      end
    end

  end
end
