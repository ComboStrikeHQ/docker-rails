# frozen_string_literal: true
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts
  end
end
