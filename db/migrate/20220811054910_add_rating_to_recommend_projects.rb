class AddRatingToRecommendProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :recommend_projects, :rating, :integer, default: 0
  end
end
