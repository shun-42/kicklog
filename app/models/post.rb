class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_one_attached :image

  validates :spike_name, presence: true
  validates :content, presence: true
  
end
