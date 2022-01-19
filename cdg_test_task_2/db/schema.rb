ActiveRecord::Schema.define(version: 2022_01_14_192601) do

  create_table "deliveries", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.float "weight"
    t.float "length"
    t.float "width"
    t.float "height"
    t.string "origin"
    t.string "destination"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "distance"
    t.decimal "price"
  end

end
