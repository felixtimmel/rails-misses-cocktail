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
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(safe_params)
    if @cocktail.save
      redirect_to cocktails_path(@cocktail)
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
    params.require(:cocktail).permit(:name)
  end
end
