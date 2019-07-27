module ProductHelpers
  def seed_products
    5.times do
      product_attributes = {}
      product_attributes[:name] = Faker::Commerce.product_name
      product_attributes[:price] = Faker::Commerce.price
      product_attributes[:category] = Faker::Commerce.department(1)
      Product.create(product_attributes)
    end
  end
end
