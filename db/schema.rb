# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_10_23_165102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.string "content", limit: 500, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "fish_species", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fishing_methods", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followings", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_followings_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_followings_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_followings_on_follower_id"
  end

  create_table "followings_infos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "followers_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.index ["user_id"], name: "index_followings_infos_on_user_id", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["post_id", "user_id"], name: "index_likes_on_post_id_and_user_id", unique: true, where: "(deleted_at IS NULL)"
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "likes_infos", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "likes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_infos_on_post_id", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.text "description", null: false
    t.bigint "user_id", null: false
    t.bigint "fish_specie_id", null: false
    t.bigint "fishing_method_id", null: false
    t.point "location"
    t.string "location_name", null: false
    t.string "rod"
    t.string "bait"
    t.decimal "weight"
    t.string "workflow_state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
    t.index ["fish_specie_id"], name: "index_posts_on_fish_specie_id"
    t.index ["fishing_method_id"], name: "index_posts_on_fishing_method_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
    t.check_constraint "srid > 0 AND srid <= 998999", name: "spatial_ref_sys_srid_check"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "password_digest", null: false
    t.string "phone_number", null: false
    t.string "phone_number_iso", limit: 2, null: false
    t.string "phone_number_confirmation_token", limit: 150
    t.string "phone_number_confirmation_code", limit: 4
    t.datetime "phone_number_confirmation_code_sent_at"
    t.string "password_recovery_token", limit: 150
    t.string "password_recovery_code", limit: 4
    t.datetime "password_recovery_code_sent_at"
    t.datetime "last_sign_in_at"
    t.string "workflow_state", null: false
    t.string "avatar"
    t.string "locale", limit: 4, default: "ge", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["phone_number"], name: "index_unique_phone_number_active", unique: true, where: "(((workflow_state)::text = 'active'::text) AND (deleted_at IS NULL))"
  end

# Could not dump table "waters" because of following StandardError
#   Unknown type 'geometry(Geometry,4326)' for column 'geometry'


  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "followings", "users", column: "followed_id"
  add_foreign_key "followings", "users", column: "follower_id"
  add_foreign_key "followings_infos", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "likes_infos", "posts"
  add_foreign_key "posts", "fish_species", column: "fish_specie_id"
  add_foreign_key "posts", "fishing_methods"
  add_foreign_key "posts", "users"
end
