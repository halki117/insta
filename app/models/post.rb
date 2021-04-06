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
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  mount_uploaders :images, ImageUploader 
  serialize :images, JSON  #JSON形式で保存する。一つのカラムに複数のデータを格納するため

  validates :images, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
end
