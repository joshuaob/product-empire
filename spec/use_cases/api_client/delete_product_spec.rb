require 'rails_helper'
require_relative '../../support/shared/an_api_client_spec'

RSpec.describe APIClient::DeleteProduct do
  let(:usecase) { described_class.new }

  it_behaves_like "an API Client"

  describe ".call" do
    context "when successful" do
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

      it "has correct status" do
        expect(@usecase.status).to eq(:no_content)
      end

      it "has no errors" do
        expect(@usecase.errors).to be_nil
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

      it "has correct status" do
        expect(@usecase.status).to eq(:not_found)
      end

      it "has errors" do
        expect(@usecase.errors).to_not be_nil
      end

      it "returns itself" do
        expect(@usecase).to be_a_kind_of(described_class)
      end
    end
  end
end
