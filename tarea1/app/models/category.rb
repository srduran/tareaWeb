class Category < ApplicationRecord
  has_many :documents
  validates :title, {presence: true, length: {in: 3..30}, uniqueness: true}
end
