class Article < ApplicationRecord
  include Discard::Model
  
  has_one_attached :preview_img
  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
