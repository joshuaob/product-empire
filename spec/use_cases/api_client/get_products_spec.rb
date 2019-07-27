require 'rails_helper'
require_relative '../../support/shared/an_api_client_spec'

RSpec.describe APIClient::GetProducts do
  let(:usecase) { described_class.new }

  it 'responds to #products' do
    expect(usecase).to respond_to(:products)
  end

  it_behaves_like "an API Client"

  describe ".call" do
    before do
      seed_products
      @usecase = described_class.call
    end

    it "is successful" do
      expect(@usecase.success?).to eq(true)
    end

    it "has many products" do
      expect(@usecase.products).to all(be_a_kind_of(Product))
    end

    it "has no errors" do
      expect(@usecase.errors).to eq(nil)
    end

    it "returns itself" do
      expect(@usecase).to be_a_kind_of(described_class)
    end
  end
end
