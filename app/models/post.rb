class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  

  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  
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
        # ユーザーテーブルと結合（joins）して、ユーザーのポジションを検索する
        Post.joins(:user).where(users: { position: content })
    else
        Post.all
    end
  end
end
  
