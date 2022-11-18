# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :shortened_urls do
      column :shortened_url, String, primary_key: true
      column :url, String, null: false
      column :created_at, DateTime, null: false

      index :url, unique: true
      index :created_at
    end
  end
end
