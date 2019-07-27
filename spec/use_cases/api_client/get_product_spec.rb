require 'rails_helper'
require_relative '../../support/shared/an_api_client_spec'

RSpec.describe APIClient::GetProduct do
  let(:usecase) { described_class.new }

  it 'responds to #product' do
    expect(usecase).to respond_to(:product)
  end

  it_behaves_like "an API Client"

  describe ".call" do
    context "when product exists" do
      before do
        product_attributes = {}
        product_attributes[:name] = Faker::Commerce.product_name
        product_attributes[:price] = Faker::Commerce.price
        product_attributes[:category] = Faker::Commerce.department(1)
        existing_product = Product.create(product_attributes)
        @usecase = described_class.call(existing_product.id)
      end

      it "is successful" do
        expect(@usecase.success?).to eq(true)
      end

      it "has a product" do
        expect(@usecase.product).to be_a_kind_of(Product)
      end

      it "has no errors" do
        expect(@usecase.errors).to eq(nil)
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end

    context "when product does not exist" do
      before do
        @usecase = described_class.call(0)
      end

      it "is unsuccessful" do
        expect(@usecase.success?).to eq(false)
      end

      it "does not have a product" do
        expect(@usecase.product).to eq(nil)
      end

      it "has errors" do
        expect(@usecase.errors).to_not eq(nil)
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end
  end
end
