class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # follow は user.rb で定義したメソッド
    
    # def follow(other_user)
    #   following << other_user
    # end

    # current_user.following << @user となり、ログインユーザーのフォローしているユーザーの中に保存される
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    # Relationship.find(params[:id])<-パラメーターで渡された id に該当する relationshipsのレコード。followedとメソッドを繋げる事でuserオブジェクトが返ってくる
    current_user.unfollow(@user)
    # unfollow は user.rb 内で定義したメソッド
    
    # def unfollow(other_user)
    #  following.destroy(other_user)
    # end

    # current_user.following.destroy(@user) となり、ログインユーザーのフォローしているユーザーの中から削除される
  end
end
