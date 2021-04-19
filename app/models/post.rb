# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :text(65535)      not null
#  images      :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy # いいねをしたユーザー(user_id), いいねされた投稿(post_id)の組み合わせを取得できる
  has_many :like_users, through: :likes, source: :user  # likesテーブルを経由して,userモデルを参照している。

  mount_uploaders :images, ImageUploader 
  serialize :images, JSON  #JSON形式で保存する。一つのカラムに複数のデータを格納するため

  validates :images, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  scope :body_contain, ->(word) { where('body LIKE ?', "%#{word}%") }
  scope :comment_body_contain, ->(word) { joins(:comments).where('comments.body LIKE ?', "%#{word}%") }
  scope :username_contain, ->(word) { joins(:user).where('username LIKE ?', "%#{word}%") }
end
