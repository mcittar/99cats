class AddUserIdColumnToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, null: false
  end
  add_index :cats, :user_id
end
