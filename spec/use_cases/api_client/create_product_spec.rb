require 'rails_helper'
require_relative '../../support/shared/an_api_client_spec'

RSpec.describe APIClient::CreateProduct do
  let(:usecase) { described_class.new }

  it 'responds to #product' do
    expect(usecase).to respond_to(:product)
  end

  it_behaves_like "an API Client"

  describe ".call" do
    context "when successful" do
      before do
        @product_attributes = {}
        @product_attributes[:name] = Faker::Commerce.product_name
        @product_attributes[:price] = Faker::Commerce.price
        @product_attributes[:category] = Faker::Commerce.department(1)
        @usecase = described_class.call(@product_attributes)
      end

      it "is successful" do
        expect(@usecase.success?).to eq(true)
      end

      it "has a correct product" do
        expect(@usecase.product).to be_a_kind_of(Product)
        expect(@usecase.product.name).to eq(@product_attributes[:name])
      end

      it "has correct status" do
        expect(@usecase.status).to eq(:created)
      end

      it "has no errors" do
        expect(@usecase.errors).to eq(nil)
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end

    context "when unsuccessful" do
      before do
        product_attributes = {}
        product_attributes[:name] = nil
        product_attributes[:price] = nil
        product_attributes[:category] = nil
        @usecase = described_class.call(product_attributes)
      end

      it "is unsuccessful" do
        expect(@usecase.success?).to eq(false)
      end

      it "does not presist a product" do
        expect(@usecase.product.persisted?).to eq(false)
      end

      it "has correct status" do
        expect(@usecase.status).to eq(:unprocessable_entity)
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
