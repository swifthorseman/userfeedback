require 'spec_helper'

describe "Creating feedback" do
  it "redirects to the feedbac index page on success" do
    visit "/feedbacks"
    click_link "New Feedback"
    expect(page).to have_content()

    fill_in "Summary", with: "Summary Text"
    fill_in "Comment", with: "Comment comment comment"
    click_button "Create Feedback"

    expect(page).to have_content()
  end

  it "displays an error when the Feedback has no Summary" do
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    click_link "New Feedback"
    expect(page).to have_content()

    fill_in "Summary", with: ""
    fill_in "Comment", with: "This is the comment text."
    click_button "Create Feedback"

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("This is the comment text.")
  end


  it "displays an error when the Feedback has a Summary less than 5 characters" do
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    click_link "New Feedback"
    expect(page).to have_content()

    fill_in "Summary", with: "Summ"
    fill_in "Comment", with: "This is the comment text."
    click_button "Create Feedback"

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("This is the comment text.")
  end

  it "displays an error when the Feedback has no Comment" do
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    click_link "New Feedback"
    expect(page).to have_content()

    fill_in "Summary", with: "Very good"
    fill_in "Comment", with: ""
    click_button "Create Feedback"

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("Very good")
  end

  it "displays an error when the Feedback has a Comment less than 10 characters" do
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    click_link "New Feedback"
    expect(page).to have_content()

    fill_in "Summary", with: "Very good"
    fill_in "Comment", with: "Nothing"
    click_button "Create Feedback"

    expect(page).to have_content("error")
    expect(Feedback.count).to eq(0)

    visit "/feedbacks"
    expect(page).to_not have_content("Nothing")
  end

end