class AddIsRecommendToRecommendProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :recommend_projects, :is_recommend, :integer, default: 1
  end
end
