class Suggestion < ApplicationRecord
  STATUS_OPTIONS = [:Pending, :Rejected, :Implemented]
  enum status_option: STATUS_OPTIONS
  belongs_to :document
  belongs_to :person

  validates :document , {presence: true}
  validates :person , {presence: true}
  validates :text , {presence: true , length: {maximum: 500}}
  validates :status , {presence: true , inclusion: { in: STATUS_OPTIONS.map {|t| t.to_s } }}
  #attr_readonly :status

  def self.searchStatus(searchStatus)
    if searchStatus == "All"
      searchStatus = ""
    end
    where("status LIKE ?", "%#{searchStatus}%")
  end

  def to_s
    return text
  end
end