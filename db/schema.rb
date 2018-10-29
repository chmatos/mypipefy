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

ActiveRecord::Schema.define(version: 20180702195459) do

  create_table "avaliacao", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "produto_id"
    t.bigint "questionario_id"
    t.bigint "oauth_accounts_id"
    t.bigint "oauth_accounts_id_adm"
    t.string "status", limit: 2, default: "P"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oauth_accounts_id"], name: "fk_aval_oauth_accounts_idx"
    t.index ["oauth_accounts_id_adm"], name: "fk_aval_oauth_accounts_adm_idx"
    t.index ["produto_id"], name: "fk_aval_prod_idx"
    t.index ["questionario_id"], name: "fk_aval_quest_idx"
  end

  create_table "avaliacao_hist", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "avaliacao_id"
    t.bigint "produto_id"
    t.bigint "questionario_id"
    t.bigint "oauth_accounts_id"
    t.string "status", limit: 2
    t.bigint "oauth_accounts_id_adm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avaliacao_id"], name: "fk_aval_hist_aval_idx"
    t.index ["oauth_accounts_id"], name: "fk_aval_hist_oauth_accounts_idx"
    t.index ["oauth_accounts_id_adm"], name: "fk_aval_hist_oauth_accounts_adm_idx"
    t.index ["produto_id"], name: "fk_aval_hist_prod_idx"
    t.index ["questionario_id"], name: "fk_aval_hist_quest_idx"
  end

  create_table "categoria", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nome", limit: 1000
    t.string "descricao", limit: 8000
    t.string "status", limit: 1, default: "A"
    t.bigint "parent_id", default: 0
    t.string "tipo", limit: 200, default: "categ"
    t.boolean "featured"
    t.bigint "featured_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categoria_produto", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "categoria_id", null: false
    t.bigint "produto_id", null: false
    t.string "status", limit: 1, default: "A"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "fk_categ_idx"
    t.index ["produto_id"], name: "fk_prod_idx"
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 1000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_rejections", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email", limit: 500
    t.datetime "data", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "leads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "oauth_account_id"
    t.integer "produto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oauth_account_id"], name: "index_leads_on_oauth_account_id"
    t.index ["produto_id"], name: "index_leads_on_produto_id"
  end

  create_table "oauth_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string "provider"
    t.string "uid"
    t.string "image_url"
    t.string "name"
    t.string "email"
    t.string "headline"
    t.string "industry"
    t.string "profile_url"
    t.string "access_token"
    t.text "raw_data", limit: 16777215
    t.integer "adm", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produto", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nome", limit: 1000
    t.string "descricao", limit: 8000
    t.string "image_banner"
    t.string "image_icon"
    t.string "status", limit: 1, default: "A"
    t.string "fab_nome", limit: 1000
    t.string "fab_url", limit: 1000
    t.bigint "oauth_accounts_id"
    t.string "oauth_accounts_id_adms", limit: 100
    t.string "url", limit: 1000
    t.string "tipo"
    t.string "product_image"
    t.string "ideal_profile", limit: 8000
    t.bigint "initial_price"
    t.bigint "price_kind"
    t.bigint "trial_kind"
    t.string "trial_other_text"
    t.boolean "access_web_navigation"
    t.boolean "access_mobile_ios"
    t.boolean "access_mobile_android"
    t.boolean "access_desktop_pc"
    t.boolean "access_desktop_apple"
    t.boolean "access_desktop_linux"
    t.bigint "support_hour_kind"
    t.boolean "support_email"
    t.boolean "support_chat"
    t.boolean "support_phone"
    t.boolean "training_video"
    t.boolean "training_text"
    t.boolean "training_presential"
    t.boolean "training_ebook"
    t.bigint "country_id"
    t.bigint "start_year"
    t.bigint "avaliacaos_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questionario", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nome", limit: 1000
    t.string "descricao", limit: 8000
    t.string "status", limit: 1, default: "A"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questionario_pergunta", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "questionario_id", null: false
    t.text "pergunta", null: false
    t.integer "sequencia"
    t.integer "pagina"
    t.string "tipo_resposta", null: false
    t.text "opcoes"
    t.string "status", limit: 1, default: "A"
    t.integer "obrigatorio", default: 0
    t.string "info", limit: 8000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionario_id"], name: "fk_quest_perg_quest_idx"
  end

  create_table "questionario_produto", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "questionario_id", null: false
    t.bigint "produto_id", null: false
    t.string "status", limit: 1, default: "A"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "fk_prod_quest_idx"
    t.index ["questionario_id"], name: "fk_quest_quest_idx"
  end

  create_table "questionario_resposta", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "avaliacao_id"
    t.bigint "questionario_pergunta_id", null: false
    t.text "resposta", null: false
    t.string "status", limit: 1, default: "A"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionario_pergunta_id"], name: "fk_quest_resp_quest_perg_idx"
  end

  add_foreign_key "avaliacao", "oauth_accounts", column: "oauth_accounts_id", name: "fk_aval_oauth_accounts"
  add_foreign_key "avaliacao", "oauth_accounts", column: "oauth_accounts_id_adm", name: "fk_aval_oauth_accounts_adm"
  add_foreign_key "avaliacao", "produto", name: "fk_aval_prod"
  add_foreign_key "avaliacao", "questionario", name: "fk_aval_quest"
  add_foreign_key "avaliacao_hist", "avaliacao", name: "fk_aval_hist_aval_idx"
  add_foreign_key "avaliacao_hist", "oauth_accounts", column: "oauth_accounts_id", name: "fk_aval_hist_oauth_accounts"
  add_foreign_key "avaliacao_hist", "oauth_accounts", column: "oauth_accounts_id_adm", name: "fk_aval_hist_oauth_accounts_adm"
  add_foreign_key "avaliacao_hist", "produto", name: "fk_aval_hist_prod"
  add_foreign_key "avaliacao_hist", "questionario", name: "fk_aval_hist_quest"
  add_foreign_key "categoria_produto", "categoria", column: "categoria_id", name: "fk_categ"
  add_foreign_key "categoria_produto", "produto", name: "fk_prod"
  add_foreign_key "questionario_pergunta", "questionario", name: "fk_quest_perg_quest"
  add_foreign_key "questionario_produto", "produto", name: "fk_prod_quest_prod"
  add_foreign_key "questionario_produto", "questionario", name: "fk_quest_quest"
  add_foreign_key "questionario_resposta", "questionario_pergunta", column: "questionario_pergunta_id", name: "fk_quest_resp_quest_perg_idx"
end
