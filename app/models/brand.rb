class Brand < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
