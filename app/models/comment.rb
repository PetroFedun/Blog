class Comment < ApplicationRecord
  include Visible

  validates :body, presence: true, length: { minimum: 1 }
  
  belongs_to :article
  belongs_to :author, class_name: 'User', foreign_key: :author_id
end

