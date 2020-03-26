require 'json'
require 'open-uri'

Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
drinks = open(url).read
drinks_list = JSON.parse(drinks)

list = drinks_list['drinks'].map do |ingredient|
  ingredient['strIngredient1']
end

list.sort.each do |item|
  Ingredient.create(name: item)
end


names = []
Cocktail.all.each { |c| names << c.name }

40.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktails = open(url).read
  cocktails_list = JSON.parse(cocktails)
  photo_url = "https://source.unsplash.com/collection/9459762/#{(1..1000).to_a.sample}"
  file = URI.open(photo_url)

  unless names.include? "#{cocktails_list['drinks'][0]['strDrink']}"
    cocktail = Cocktail.new(
                  name: "#{cocktails_list['drinks'][0]['strDrink']}",
                  instructions: "#{cocktails_list['drinks'][0]['strInstructions']}",
                  )
    cocktail.photo.attach(io: file, filename: "#{:name}.jpg", content_type: 'image/jpg')
    cocktail.save

    num = 1
    doses = []
    until num == 15
      ingredient = cocktails_list['drinks'][0]["strIngredient#{num}"]
      if ingredient && ingredient != "" && ingredient != "null"
        doses << "#{cocktails_list['drinks'][0]["strMeasure#{num}"]}:#{cocktails_list['drinks'][0]["strIngredient#{num}"]}"
      end
      num += 1
    end

    doses.each do |d|
      a = d.split(':')
      dose = Dose.new(description: a.first)
      dose.cocktail_id = cocktail.id
      if Ingredient.find_by(name: a.last) != nil
        ing = Ingredient.find_by(name: a.last)
        dose.ingredient_id = ing.id
        dose.save
      end
    end
  end
end

