
ActiveRecord::Schema[7.0].define(version: 2023_08_31_133731) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id", null: false
  end

  create_table "checkpoints", force: :cascade do |t|
    t.string "nome"
    t.string "descrizione"
    t.boolean "completato", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id", null: false
    t.index ["project_id"], name: "index_checkpoints_on_project_id"
  end

  create_table "field_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_fields_on_nome", unique: true
  end

  create_table "fields_projects", force: :cascade do |t|
    t.integer "project_id"
    t.integer "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "field_id", null: false
    t.index ["user_id", "field_id"], name: "index_fields_users_on_user_id_and_field_id"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content", limit: 50, null: false
    t.integer "user_id", null: false
    t.integer "chat_id", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "info_leader", null: false
    t.integer "dimensione", null: false
    t.string "descrizione", null: false
    t.string "stato", default: "aperto", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "github_link"
  end

  create_table "reports", force: :cascade do |t|
    t.string "descrizione"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "note"
    t.string "stato_accettazione"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.index ["project_id"], name: "index_requests_on_project_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "nome"
    t.string "descrizione"
    t.boolean "completato", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "checkpoint_id", null: false
    t.index ["checkpoint_id"], name: "index_tasks_on_checkpoint_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "member", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "chats", "projects"
  add_foreign_key "checkpoints", "projects"
  add_foreign_key "fields_projects", "fields", on_delete: :cascade
  add_foreign_key "fields_projects", "projects", on_delete: :cascade
  add_foreign_key "fields_users", "fields", on_delete: :cascade
  add_foreign_key "fields_users", "users", on_delete: :cascade
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "reports", "users"
  add_foreign_key "requests", "projects", on_delete: :cascade
  add_foreign_key "requests", "users", on_delete: :cascade
  add_foreign_key "tasks", "checkpoints"
  add_foreign_key "user_projects", "projects", on_delete: :cascade
  add_foreign_key "user_projects", "users", on_delete: :cascade
end
