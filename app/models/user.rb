# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  name             :string(255)      not null
#  profile_photo    :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationship, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follwers, through: :passive_relationship, source: :follower

  def own?(object)
    id == object.user_id
  end
  
  def like(post)
    like_posts << post #ユーザのいいねした投稿が追加される
  end

  def unlike(post)
    like_posts.destroy(post) #destroy(post) 引数に削除したいpost.idを渡している
  end

  def like?(post) 
    like_posts.include?(post) #ユーザーが投稿に対していいねしたか判断 
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.destroy(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
end
