
require './db/seeds/users'
require './db/seeds/posts'

# postsテーブルのuser_id nilカラムには nil: false 制約をつけているので必ず userのデータから生成する様にする！！