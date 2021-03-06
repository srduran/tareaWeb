class Document < ApplicationRecord
  has_many :categories
  has_many :likes
  has_many :people, through: :likes
  validates :title, {presence: true, length: {in: 10..50}, uniqueness: true}
  validates :text, {presence: true, length: {minimum: 10}}

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end

  def to_s
    return title
  end
end
