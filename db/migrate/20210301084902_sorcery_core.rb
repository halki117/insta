class SorceryCore < ActiveRecord::Migration[5.2]
  create_table "users", force: :cascade do |t|
    t.string   "name", null: false
    t.string   "email",null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
