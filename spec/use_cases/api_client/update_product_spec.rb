require 'rails_helper'
require_relative '../../support/shared/an_api_client_spec'

RSpec.describe APIClient::UpdateProduct do
  let(:usecase) { described_class.new }

  it 'responds to #product' do
    expect(usecase).to respond_to(:product)
  end

  it_behaves_like "an API Client"

  describe ".call" do
    context "when successful" do
      before do
        product_attributes = {}
        product_attributes[:name] = Faker::Commerce.product_name
        product_attributes[:price] = Faker::Commerce.price
        product_attributes[:category] = Faker::Commerce.department(1)

        @product_attributes = {}
        @product_attributes[:name] = Faker::Commerce.product_name
        @product_attributes[:category] = Faker::Commerce.department(1)

        existing_product = Product.create(product_attributes)

        @usecase = described_class.call(existing_product.id, @product_attributes)
      end

      it "is successful" do
        expect(@usecase.success?).to eq(true)
      end

      it "has correct status" do
        expect(@usecase.status).to eq(:ok)
      end

      it "has no errors" do
        expect(@usecase.errors).to be_nil
      end

      it "updates an existing product correctly" do
        expect(@usecase.product).to be_a_kind_of(Product)
        expect(@usecase.product.name).to eq(@product_attributes[:name])
        expect(@usecase.product.category).to eq(@product_attributes[:category])
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end

    context "when product does not exist" do
      before do
        product_attributes = {}
        product_attributes[:name] = Faker::Commerce.product_name
        @usecase = described_class.call(0, product_attributes)
      end

      it "is unsuccessful" do
        expect(@usecase.success?).to eq(false)
      end

      it "has correct status" do
        expect(@usecase.status).to eq(:not_found)
      end

      it "has errors" do
        expect(@usecase.errors).to_not be_nil
      end

      it "does not have a product" do
        expect(@usecase.product).to eq(nil)
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end

    context "when unsuccessful" do
      before do
        product_attributes = {}
        product_attributes[:name] = Faker::Commerce.product_name
        product_attributes[:price] = Faker::Commerce.price
        product_attributes[:category] = Faker::Commerce.department(1)

        @product_attributes = {}
        @product_attributes[:name] = nil
        @product_attributes[:price] = nil
        @product_attributes[:category] = nil

        existing_product = Product.create(product_attributes)

        @usecase = described_class.call(existing_product.id, @product_attributes)
      end

      it "is unsuccessful" do
        expect(@usecase.success?).to eq(false)
      end

      it "has correct status" do
        expect(@usecase.status).to eq(:unprocessable_entity)
      end

      it "has errors" do
        expect(@usecase.errors).to_not be_nil
      end

      it "does not update a product" do
        expect(@usecase.product.name).to_not eq(@product_attributes[:name])
        expect(@usecase.product.price).to_not eq(@product_attributes[:price])
        expect(@usecase.product.category).to_not eq(@product_attributes[:category])
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end
  end
end
