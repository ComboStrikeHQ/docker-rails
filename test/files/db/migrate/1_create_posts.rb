# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts
  end
end
