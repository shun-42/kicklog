class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_one_attached :image
end
