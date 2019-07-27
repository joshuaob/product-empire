require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) do
    a_product = described_class.new
    a_product.name = Faker::Commerce.product_name
    a_product.price = Faker::Commerce.price
    a_product.category = Faker::Commerce.department(1)
    a_product
  end

  it "responds to name" do
    expect(product).to respond_to(:name)
  end

  it "responds to price" do
    expect(product).to respond_to(:price)
  end

  it "responds to category" do
    expect(product).to respond_to(:category)
  end

  it "responds to added_at" do
    expect(product).to respond_to(:added_at)
  end

  it "responds to created_at" do
    expect(product).to respond_to(:created_at)
  end

  it "responds to updated_at" do
    expect(product).to respond_to(:updated_at)
  end

  it "is invalid without a name" do
    product.name = nil
    expect(product).to_not be_valid
    expect(product.errors).to include(:name)
  end

  it "is invalid without a price" do
    product.price = nil
    expect(product).to_not be_valid
    expect(product.errors).to include(:price)
  end

  it "is invalid without a category" do
    product.category = nil
    expect(product).to_not be_valid
    expect(product.errors).to include(:category)
  end
end
