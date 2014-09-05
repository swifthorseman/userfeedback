require 'spec_helper'

describe "Creating feedback" do
  def create_feedback(options={})
    options[:summary] ||= "Summary"
    options[:comment] ||= "No comment."

    visit "/feedbacks"
    click_link "New Feedback"
    expect(page).to have_content()

    fill_in "Summary", with: options[:summary]
    fill_in "Comment", with: options[:comment]
    click_button "Create Feedback"
  end


  it "redirects to the feedbac index page on success" do
    create_feedback

    expect(page).to have_content()
  end

  it "displays an error when the Feedback has no Summary" do
    expect(Feedback.count).to eq(0)

    create_feedback summary: ""

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("This is the comment text.")
  end


  it "displays an error when the Feedback has a Summary less than 5 characters" do
    expect(Feedback.count).to eq(0)

    create_feedback summary: "Summ"

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("This is the comment text.")
  end

  it "displays an error when the Feedback has no Comment" do
    expect(Feedback.count).to eq(0)

    create_feedback summary: "Very good", comment: ""

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("Very good")
  end

  it "displays an error when the Feedback has a Comment less than 10 characters" do
    expect(Feedback.count).to eq(0)

    create_feedback summary: "Very good", comment: "Nothing"

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("Nothing")
  end

end