require 'open-uri'

class CocktailsController < ApplicationController
  def index
    if params[:search].nil?
      @cocktails = Cocktail.all
    else
      @search = params[:search]
      @cocktails = Cocktail.where("lower(#{:name}) LIKE ?", "%#{@search.downcase}%")
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @review = Review.new
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(safe_params)
    if @cocktail.save && !@cocktail.photo.attachment.nil?
      redirect_to new_cocktail_dose_path(@cocktail)
    elsif @cocktail.save && @cocktail.photo.attachment.nil?
      photo_url = "https://source.unsplash.com/collection/9459762/#{(1..1000).to_a.sample}"
      file = URI.open(photo_url)
      @cocktail.photo.attach(io: file, filename: "random_photo.jpg", content_type: 'image/jpg')
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render 'new'
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def safe_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
