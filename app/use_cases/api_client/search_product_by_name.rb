module APIClient
  class SearchProductByName < Base
    attr_accessor :product

    def self.call(name)
      usecase = new
      usecase.product = Product.where(name: name).first

      if usecase.product
        usecase.status = :ok
      else
        usecase.status = :not_found
        usecase.errors = [{ "title": "Product not found", "detail": "Product not found" }]
      end

      usecase
    end
  end
end
