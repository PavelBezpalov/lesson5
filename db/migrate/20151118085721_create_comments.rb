class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :user, index: true, required: true
      t.belongs_to :post, index: true, required: true

      t.timestamps null: false
    end
  end
end
