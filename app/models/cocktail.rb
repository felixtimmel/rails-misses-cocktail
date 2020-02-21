class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo

  validates :name, uniqueness: true, presence: true
  validates :rating, :inclusion => { :in => [0, 1, 2, 3, 4], :allow_nil => true }
end
