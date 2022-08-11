class CreateRecommendProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :recommend_projects do |t|
      t.integer :user_id
      t.integer :status
      t.string  :name
      t.string  :website
      t.string  :logo
      t.string  :cost
      t.text    :desc
      t.text    :reason

      t.timestamps
    end

    add_index :recommend_projects, :user_id
    add_index :recommend_projects, :status
  end
end
