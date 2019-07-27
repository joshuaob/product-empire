# require 'jsonapi-serializers'

class ProductSerializer
  include JSONAPI::Serializer

  attribute :name
  attribute :price
  attribute :category
  attribute :updated_at
  attribute :added_at do
    object.added_at
  end
end
