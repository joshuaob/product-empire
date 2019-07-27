class Product < ApplicationRecord

  validates :name, :price, :category, presence: true

  def added_at
    created_at
  end
end
