class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, index: true, required: true
      t.belongs_to :post, index: true, required: true

      t.boolean :positive, default: true
      t.timestamps null: false
    end
  end
end
