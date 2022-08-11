class UserComment < ApplicationRecord
  belongs_to :user
  belongs_to :recommend_project

  has_rich_text :content
end