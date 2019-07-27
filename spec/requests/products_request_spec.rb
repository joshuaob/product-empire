require 'rails_helper'

RSpec.describe "Products API", :type => :request do
  describe "GET /products" do
    before(:all) do
      seed_products
      get '/products'
    end

    it "responds with a status of 200" do
      expect(response.status).to eq(200)
    end

    it "responds with a collection of products" do
      expect(response).to match_response_schema("products")
    end

    context "when name filter is present" do
      before(:all) do
        product_attributes = {}
        product_attributes[:name] = Faker::Commerce.product_name
        product_attributes[:price] = Faker::Commerce.price
        product_attributes[:category] = Faker::Commerce.department(1)
        existing_product = Product.create(product_attributes)
        get "/products?filter[name]=#{existing_product.name}"
      end

      it "responds with a status of 200" do
        expect(response.status).to eq(200)
      end

      it "responds with a product" do
        expect(response).to match_response_schema("product")
      end
    end
  end

  describe "GET /products/:id" do
    context "when product exists" do
      before(:all) do
        product_attributes = {}
        product_attributes[:name] = Faker::Commerce.product_name
        product_attributes[:price] = Faker::Commerce.price
        product_attributes[:category] = Faker::Commerce.department(1)
        existing_product = Product.create(product_attributes)
        get "/products/#{existing_product.id}"
      end

      it "responds with a status of 200" do
        expect(response.status).to eq(200)
      end

      it "responds with a product" do
        expect(response).to match_response_schema("product")
      end
    end

    context "when product does not exist" do
      before(:all) do
        get '/products/0'
      end

      it "responds with a status of 404" do
        expect(response.status).to eq(404)
      end

      it "responds with an error" do
        expect(response).to match_response_schema("error")
      end
    end
  end

  describe "POST /products" do
    context "when request params is valid" do
      before(:all) do
        request_params = {}
        request_params[:product] = {}
        request_params[:product][:name] = Faker::Commerce.product_name
        request_params[:product][:price] = Faker::Commerce.price
        request_params[:product][:category] = Faker::Commerce.department(1)
        post '/products', params: request_params
      end

      it "responds with a status of 201" do
        expect(response.status).to eq(201)
      end

      it "responds with a product" do
        expect(response).to match_response_schema("product")
      end
    end

    context "when request params is invalid" do
      before(:all) do
        request_params = {}
        request_params[:product] = {}
        request_params[:product][:name] = Faker::Commerce.product_name
        post '/products', params: request_params
      end

      it "responds with a status of 422" do
        expect(response.status).to eq(422)
      end

      it "responds with an error" do
        expect(response).to match_response_schema("error")
      end
    end
  end

  describe "PATCH /products/:id" do
    context "when product does not exist" do
      before(:all) do
        request_params = {}
        request_params[:product] = {}
        request_params[:product][:name] = Faker::Commerce.product_name
        patch '/products/0', params: request_params
      end

      it "responds with a status of 404" do
        expect(response.status).to eq(404)
      end

      it "responds with an error" do
        expect(response).to match_response_schema("error")
      end
    end

    context "when request params is valid" do
      before(:all) do
        request_params = {}
        request_params[:product] = {}
        request_params[:product][:name] = Faker::Commerce.product_name
        request_params[:product][:category] = Faker::Commerce.department(1)
        existing_product = Product.create(request_params[:product])

        @product_attributes = {}
        @product_attributes[:product] = {}
        @product_attributes[:product][:name] = Faker::Commerce.product_name
        @product_attributes[:product][:category] = Faker::Commerce.department(1)

        patch "/products/1", params: @product_attributes
      end

      it "responds with a status of 200" do
        expect(response.status).to eq(200)
      end

      it "responds with a product" do
        expect(response).to match_response_schema("product")
      end
    end

    context "when request params is invalid" do
      before(:all) do
        request_params = {}
        request_params[:product] = {}
        request_params[:product][:name] = Faker::Commerce.product_name
        request_params[:product][:category] = Faker::Commerce.department(1)
        existing_product = Product.create(request_params[:product])

        @product_attributes = {}
        @product_attributes[:product] = {}
        @product_attributes[:product][:name] = nil
        @product_attributes[:product][:category] = nil

        patch "/products/1", params: @product_attributes
      end

      it "responds with a status of 422" do
        expect(response.status).to eq(422)
      end

      it "responds with an error" do
        expect(response).to match_response_schema("error")
      end
    end
  end

  describe "DELETE /products/:id" do
    context "when product does not exist" do
      before(:all) do
        delete '/products/0'
      end

      it "responds with a status of 404" do
        expect(response.status).to eq(404)
      end

      it "responds with an error" do
        expect(response).to match_response_schema("error")
      end
    end

    context "when product exists" do
      before(:all) do
        delete '/products/1'
      end

      it "responds with a status of 204" do
        expect(response.status).to eq(204)
      end
    end
  end
end
