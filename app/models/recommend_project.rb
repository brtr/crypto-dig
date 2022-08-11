class RecommendProject < ApplicationRecord
  belongs_to :user
  has_many :user_comments
  has_rich_text :desc
  mount_uploader :logo, ImageUploader

  enum status: [:submitted, :approved]

  before_create :set_status

  def self.custom_sort(params)
    case params
    when "tag"
      order("tags.name asc")
    when "name"
      order(name: :asc)
    else
      order(created_at: :desc)
    end
  end

  def rating
    user_comments.average(:rating)
  end

  private
  def set_status
    self.status = "submitted"
  end
end
