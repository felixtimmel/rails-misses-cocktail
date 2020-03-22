class ReviewsController < ApplicationController
  def new
  end

  def create
    @review = Review.new(review_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @review.cocktail = @cocktail
    if @review.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'cocktails/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
