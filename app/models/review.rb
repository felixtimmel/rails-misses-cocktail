class Review < ApplicationRecord
  belongs_to :cocktail

  validates :rating, inclusion: {in: [0, 1, 2, 3, 4, 5]}

end
