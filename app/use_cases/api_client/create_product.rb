module APIClient
  class CreateProduct < Base
    attr_accessor :product

    def self.call(product_attributes)
      usecase = new
      usecase.product = Product.new(product_attributes)
      
      if usecase.product.save
        usecase.status = :created
      else
        usecase.errors = usecase.product.errors
        usecase.status = :unprocessable_entity
      end

      usecase
    end
  end
end
