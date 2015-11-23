class CreatePostsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :starred, id: false do |t|
      t.integer :user_id, index: true, required: true
      t.integer :post_id, index: true, required: true
    end
  end
end
