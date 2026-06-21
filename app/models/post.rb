class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  

  has_one_attached :image
  has_many :post_comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  
  validates :spike_name, presence: true
  validates :content, presence: true

  def self.search_for(content, method, category)
    if category == 'name'
        if method == 'perfect'
          Post.where(name: content)
        else
          Post.where('name LIKE ?', '%' + content + '%')
        end
    elsif category == 'position'
        Post.joins(:user).where(users: { position: content })
    elsif category == 'play_style'
        Post.joins(:user).where(users: { play_style: content })
    else
        Post.all
    end
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
  
