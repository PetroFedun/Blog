class Article < ApplicationRecord
  has_one_attached :preview_img
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
