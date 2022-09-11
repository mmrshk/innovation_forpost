# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_02_070934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "article_tags", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id", "tag_id"], name: "index_article_tags_on_article_id_and_tag_id", unique: true
    t.index ["article_id"], name: "index_article_tags_on_article_id"
    t.index ["tag_id"], name: "index_article_tags_on_tag_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.integer "language", default: 0
    t.index ["title"], name: "index_articles_on_title"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_attachments_on_name"
  end

  create_table "ck_editor_images", force: :cascade do |t|
    t.string "file"
    t.bigint "article_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.index ["article_id"], name: "index_ck_editor_images_on_article_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.integer "start_year", default: 2010
    t.integer "projects_count", default: 0
    t.integer "clients_count", default: 0
    t.integer "grants_count", default: 0
    t.string "text_about", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "language", default: 0
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_documents_on_ancestry"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.string "user_name", null: false
    t.string "user_email"
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "article_tags", "articles"
  add_foreign_key "article_tags", "tags"
  add_foreign_key "articles", "users"
  add_foreign_key "ck_editor_images", "articles"

  create_view "articles_db_views", sql_definition: <<-SQL
      SELECT article_tags.article_id,
      articles.title,
      articles.created_at,
      tags.name AS tag_name,
      articles.text
     FROM ((articles
       LEFT JOIN article_tags ON ((article_tags.article_id = articles.id)))
       LEFT JOIN tags ON ((article_tags.tag_id = tags.id)))
    WHERE ((articles.user_id = ( SELECT users.id
             FROM users
            WHERE ((users.email)::text = 'admin@example.com'::text))) AND ( SELECT (date_part('day'::text, ((CURRENT_DATE)::timestamp without time zone - articles.updated_at)) < (14)::double precision)) AND ( SELECT ((tags.name)::text = ANY ((ARRAY['work'::character varying, 'Work'::character varying, 'робота'::character varying, 'Робота'::character varying])::text[]))))
    ORDER BY articles.created_at DESC;
  SQL
  create_view "return_articles", sql_definition: <<-SQL
      SELECT articles.id AS article_id,
      articles.status,
      articles.language,
      users.id AS user_id,
      users.email,
      string_agg((tags.name)::text, ','::text) AS tag_names,
      count(ck_editor_images.file) AS images_count
     FROM ((((articles
       LEFT JOIN article_tags ON ((articles.id = article_tags.article_id)))
       JOIN users ON ((articles.user_id = users.id)))
       LEFT JOIN tags ON ((article_tags.tag_id = tags.id)))
       LEFT JOIN ck_editor_images ON ((articles.id = ck_editor_images.id)))
    GROUP BY articles.id, users.id;
  SQL
end
