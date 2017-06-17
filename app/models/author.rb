class Author < ApplicationRecord
  belongs_to :person
  belongs_to :document
end
