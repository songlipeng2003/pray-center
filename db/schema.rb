# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160809110854) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "auth_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone"
    t.string   "code"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "favorite_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "favorited_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["favorited_user_id"], name: "index_favorite_users_on_favorited_user_id", using: :btree
    t.index ["user_id"], name: "index_favorite_users_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "actor_id"
    t.string   "type"
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "second_target_type"
    t.integer  "second_target_id"
    t.string   "content"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["actor_id"], name: "index_notifications_on_actor_id", using: :btree
    t.index ["second_target_type", "second_target_id"], name: "index_notifications_on_second_target_type_and_second_target_id", using: :btree
    t.index ["target_type", "target_id"], name: "index_notifications_on_target_type_and_target_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "content",     limit: 65535
    t.integer  "pray_number",               default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "region_id"
    t.index ["category_id"], name: "index_posts_on_category_id", using: :btree
    t.index ["region_id"], name: "index_posts_on_region_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "pray_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_pray_histories_on_post_id", using: :btree
    t.index ["user_id"], name: "index_pray_histories_on_user_id", using: :btree
  end

  create_table "regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "gender"
    t.date     "birth"
    t.integer  "education"
    t.string   "job"
    t.string   "church"
    t.string   "church_service"
    t.date     "rebirth"
    t.integer  "area"
    t.string   "period"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.integer  "sign_in_count",        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",      default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.integer  "parent_id"
    t.datetime "online_at"
    t.string   "avatar"
    t.index ["parent_id"], name: "index_users_on_parent_id", using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "posts", "categories"
  add_foreign_key "posts", "users"
  add_foreign_key "pray_histories", "posts"
  add_foreign_key "pray_histories", "users"
end
