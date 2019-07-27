module APIClient
  class UpdateProduct < Base
    attr_accessor :product

    def self.call(id, product_attributes)
      usecase = new
      usecase.product = Product.find(id)

      if usecase.product.update(product_attributes)
        usecase.status = :ok
      else
        usecase.errors = usecase.product.errors
        usecase.status = :unprocessable_entity
      end

      usecase.product.reload
      usecase

    rescue ActiveRecord::RecordNotFound => e
      usecase.status = :not_found
      usecase.errors = [{ "title": "Product not found", "detail": "Product not found" }]
      usecase
    end
  end
end
