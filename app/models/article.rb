class Article < ApplicationRecord
  has_one_attached :preview_img
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  
  belongs_to :author, class_name: 'User', foreign_key: :author_id
end
