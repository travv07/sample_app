class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.microposts.maximum_content}
  validate :picture_size

  scope :feed, ->(id){where(user_id: id)}
  scope :order_by_created_at, ->{order(created_at: :desc)}
  private
    def picture_size
      if picture.size > Settings.microposts.size_picture.megabytes
        errors.add(:picture, t(".microposts.micropost.size_picture"))
      end
    end
end
