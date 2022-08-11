class CreateUserComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_comments do |t|
      t.integer :user_id
      t.integer :recommend_project_id
      t.integer :rating
      t.text    :content

      t.timestamps
    end

    add_index :user_comments, :user_id
    add_index :user_comments, :recommend_project_id
  end
end
