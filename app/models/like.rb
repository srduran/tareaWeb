class Like < ApplicationRecord
  belongs_to :person, class_name: 'Person', foreign_key: 'person_id'
  belongs_to :document, class_name: 'Document', foreign_key: 'document_id'

  validates :person, presence: true
  validates :document, presence: true
  validates_uniqueness_of :document_id, :scope => :person_id
end
