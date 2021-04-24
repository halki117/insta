class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  # ActiveModel::Model でデータベースに依存しないモデルを生成
  # ActiveModel::Attributes で属性を定義する

  attribute :body, :string
  attribute :comment_body, :string
  attribute :username, :string

  def search
    scope = Post.distinct
    scope = splited_bodies.map { |splited_body| scope.body_contain(splited_body) }.inject { |result, scp| result.or(scp) } if body.present?
    scope = scope.comment_body_contain(body) if comment_body.present?
    scope = scope.username_contain(username) if username.present?
    scope
  end

  
  # body_contain 
  # comment_body_contain
  # username_contain
  # これらはPostモデル内で定義されている
  
  private

  def splited_bodies
    body.strip.split(/[[:blank:]]+/) #入力した文字の前と後ろの空白を取り除く、また文字と文字の間の空白を基に配列に切り分けている /[[:blank:]]+/ と引数に渡す事で全角にも対応できる
  end
end

