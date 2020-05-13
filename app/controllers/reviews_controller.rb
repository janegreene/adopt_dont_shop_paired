class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.new(review_params)
    if review.save
        redirect_to "/shelters/#{@shelter.id}"
    else
        flash.now[:notice] = "Review not created: Required information missing."
        render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    review = Review.find(params[:review_id])
    if review.valid?
      review.update!(review_params)
      redirect_to "/shelters/#{review.shelter_id}"
    else
      redirect_to "/shelters/#{review.shelter_id}/#{review.id}/edit" 
      flash[:notice] = "Review not updated: Required information missing."
    end
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{@shelter.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
