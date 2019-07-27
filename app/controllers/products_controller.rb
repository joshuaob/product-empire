class ProductsController < ApplicationController
  def index
    usecase = APIClient::GetProducts.call
    render json: JSONAPI::Serializer.serialize(usecase.products, is_collection: true), status: usecase.status
  end

  def create
    usecase = APIClient::CreateProduct.call(product_params)

    if usecase.success?
      render json: JSONAPI::Serializer.serialize(usecase.product), status: usecase.status
    else
      render json: JSONAPI::Serializer.serialize_errors(usecase.errors), status: usecase.status
    end
  end

  def update
    usecase = APIClient::UpdateProduct.call(params[:id], product_params)

    if usecase.success?
      render json: JSONAPI::Serializer.serialize(usecase.product), status: usecase.status
    else
      render json: JSONAPI::Serializer.serialize_errors(usecase.errors), status: usecase.status
    end
  end

  def show
    usecase = APIClient::GetProduct.call(params[:id])

    if usecase.success?
      render json: JSONAPI::Serializer.serialize(usecase.product), status: usecase.status
    else
      errors = [{ "title": "Product not found", "detail": "Product not found" }]
      render json: JSONAPI::Serializer.serialize_errors(errors), status: usecase.status
    end
  end

  def destroy
    usecase = APIClient::DeleteProduct.call(params[:id])

    if usecase.success?
      head :no_content
    else
      render json: JSONAPI::Serializer.serialize_errors(usecase.errors), status: usecase.status
    end
  end

  def search
    # usecase = APIClient::UpdateProduct.call(product_params)
    #
    # if usecase.success
    #   render json: JSONAPI::Serializer.serialize(usecase.product), status: :ok
    # else
    #   render json: JSONAPI::Serializer.serialize_errors(usecase.product.errors), status: :unprocessable_entity
    # end
  end

  private

   def product_params
     params.require(:product).permit(:name,
                                      :price,
                                      :category,
                                      :added_at,
                                      :updated_at)
   end
end
