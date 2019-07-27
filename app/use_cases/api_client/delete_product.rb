module APIClient
  class DeleteProduct < Base
    def self.call(id)
      usecase = new
      product = Product.find(id)
      usecase.status = :no_content if product.delete
      usecase

    rescue ActiveRecord::RecordNotFound => e
      usecase.status = :not_found
      usecase.errors = [{ "title": "Product not found", "detail": "Product not found" }]
      usecase
    end
  end
end
