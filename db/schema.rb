ActiveRecord::Schema[7.0].define(version: 2022_07_03_184752) do
  enable_extension "plpgsql"

  create_table "agendas", force: :cascade do |t|
    t.string "title"
    t.string "keywords", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_sources", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "credibility"
  end

  create_table "stakeholders", force: :cascade do |t|
    t.string "name", null: false
    t.string "position"
    t.string "twitter_handler"
    t.string "instagram_handler"
    t.string "role"
    t.string "phone"
    t.string "email"
    t.string "organization"
    t.integer "agenda_id"
  end

end
