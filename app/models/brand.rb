class Brand < ApplicationRecord
  has_many :posts, dependent: :destroy

  def self.find(input)
    find_by(name: input) || super
  end
  
end
