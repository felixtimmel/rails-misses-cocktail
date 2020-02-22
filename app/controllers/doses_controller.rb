class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(safe_params)
    @dose.cocktail_id = params[:cocktail_id]
    @dose.ingredient_id = params[:dose][:ingredient_id]
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail_id)
    else
      render 'doses/new'
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def safe_params
    params.require(:dose).permit(:description, :ingredient)
  end
end
