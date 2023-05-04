class RemoveColumnsFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :commenter, :string
    remove_column :comments, :status, :string
    remove_column :comments, :default, :string
    remove_column :comments, :public, :string
  end
end
