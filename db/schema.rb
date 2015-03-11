# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150227115422) do

  create_table "aliases", force: :cascade do |t|
    t.string  "name",      null: false
    t.integer "book_id"
    t.integer "school_id"
  end

  add_index "aliases", ["school_id", "book_id"], name: "index_aliases_on_school_id_and_book_id"
  add_index "aliases", ["school_id", "name"], name: "index_aliases_on_school_id_and_name", unique: true

  create_table "base_sets", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "base_sets", ["book_id"], name: "index_base_sets_on_book_id"
  add_index "base_sets", ["student_id", "book_id"], name: "index_base_sets_on_student_id_and_book_id", unique: true
  add_index "base_sets", ["student_id"], name: "index_base_sets_on_student_id"

  create_table "books", force: :cascade do |t|
    t.string   "isbn",       null: false
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn"

  create_table "lendings", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "person_type"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lendings", ["book_id"], name: "index_lendings_on_book_id"
  add_index "lendings", ["person_type", "person_id"], name: "index_lendings_on_person_type_and_person_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name",            null: false
    t.integer  "graduation_year", null: false
    t.string   "class_letter"
    t.string   "string"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "students", ["school_id"], name: "index_students_on_school_id"

  create_table "teachers", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teachers", ["school_id"], name: "index_teachers_on_school_id"

  create_table "usages", force: :cascade do |t|
    t.integer "school_id"
    t.integer "book_id"
    t.string  "form",      null: false
  end

  add_index "usages", ["book_id"], name: "index_usages_on_book_id"
  add_index "usages", ["school_id", "book_id"], name: "index_usages_on_school_id_and_book_id", unique: true
  add_index "usages", ["school_id"], name: "index_usages_on_school_id"

end
