require 'json'
require 'open-uri'

Ingredient.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
drinks = open(url).read
drinks_list = JSON.parse(drinks)

list = drinks_list['drinks'].map do |ingredient|
  ingredient['strIngredient1']
end

list.sort.each do |item|
  Ingredient.create(name: item)
end
