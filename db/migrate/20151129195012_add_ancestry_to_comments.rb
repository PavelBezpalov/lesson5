class AddAncestryToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ancestry, :string, index: true
  end
end
