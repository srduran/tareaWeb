class Document < ApplicationRecord
  belongs_to :categories
  validates :title, {presence: true, length: {in: 10..50}, uniqueness: true}
  validates :text, {presence: true, length: {minimum: 10}}

end
