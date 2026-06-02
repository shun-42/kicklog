class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :brand
  has_one_attached :image
end
