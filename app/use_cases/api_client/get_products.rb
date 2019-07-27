module APIClient
  class GetProducts < Base
    attr_accessor :products

    def self.call
      usecase = new
      usecase.products = Product.all
      usecase.status = :ok
      usecase
    end
  end
end
