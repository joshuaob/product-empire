module APIClient
  class GetProduct < Base
    attr_accessor :product

    def self.call(id)
      usecase = new
      usecase.product = Product.find(id)
      usecase.status = :ok
      usecase

    rescue ActiveRecord::RecordNotFound => e
      usecase.status = :not_found
      usecase.errors = [{ "title": "Product not found", "detail": "Product not found" }]
      usecase
    end
  end
end
