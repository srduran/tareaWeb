class Category < ApplicationRecord
  has_many :documents
  validates :title, {presence: true, length: {in: 3..30}, uniqueness: true}

  def to_s
    return title
  end
end
