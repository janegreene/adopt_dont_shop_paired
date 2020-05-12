require 'rails_helper'

RSpec.describe "from shelter show page" do
  it "see a link to add a new review for this shelter" do
    shelter = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )
    visit "/shelters/#{shelter.id}"

    click_link "Review"
    expect(current_path).to eq("/shelters/#{shelter.id}/review")

    fill_in "Title", with: "Could be better, could be worse."
    fill_in "Rating", with: 4
    fill_in "Content", with: "Oddly smells like mustard."
    fill_in "Image", with: "https://canineweekly.com/wp-content/uploads/2017/10/big-fluffy-dog-breeds-1024x683.jpg"

    click_button "Submit Review"
    review_1 = Review.last
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("Could be better, could be worse.")
    expect(page).to have_content(4)
    expect(page).to have_content("Oddly smells like mustard.")
    page.find("#review-avatar-#{review_1.id}")['src'].should have_content review_1.image
  end

  it "see a link to edit the shelter review next to each review" do
    shelter = Shelter.create(name: "Find-a-Friend",
                              address: "123 North Street",
                              city: "Denver",
                              state: "CO",
                              zip: 80223 )
    review = Review.create(title: "Excellent service",
                           rating: 5,
                           content: "Found a great pet for my family.",
                           image: "https://images.unsplash.com/photo-1415369629372-26f2fe60c467?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
                           shelter_id: shelter.id )

    visit "/shelters/#{shelter.id}"
# require "pry"; binding.pry
    click_link "Edit Review"
    expect(current_path).to eq("/shelters/#{shelter.id}/#{review.id}/edit")
    fill_in "Content", with: "The dog we got from here is AMAZING!"

    click_button "Submit Review"
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("Excellent service")
    expect(page).to have_content(5)
    expect(page).to have_content("The dog we got from here is AMAZING!")
    page.find("#review-avatar-#{review.id}")['src'].should have_content review.image
  end
end
# User Story 5, Edit a Shelter Review
#
# As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review
#
# # User Story 3, Shelter Review Creation
# # rails g migration CreateReview title:string rating:integer content:string image:string shelter:references
# # As a visitor,
# # When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
