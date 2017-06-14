class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, {presence: true , length: {in: 3..30}}
  validates :last_name, {presence: true, length: {in:3..30}}
  validates :email, {presence: true, length: {maximum: 50}, uniqueness: true}
  validates :password, {presence: true, length: {minimum: 8}, confirmation: true}

  def to_s
    return (first_name + " " +last_name)
  end
end
