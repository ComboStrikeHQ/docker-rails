# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts
  end
end
