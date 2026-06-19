class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :position, presence: true

  validates :play_style, presence: true, inclusion: { in: [
    "ストライカー（ワンタッチゴール・オフザボール）",
    "ターゲットマン・ポストプレー",
    "ドリブラー",
    "パサー",
    "デュエル・ボール奪取",
    "ビルドアップ",
    "オーバーラップ",
    "セービング",
    "未定"
  ] }
  
end
