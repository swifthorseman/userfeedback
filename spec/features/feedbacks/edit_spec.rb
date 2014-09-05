require 'spec_helper'

describe "Editing feedback" do
  let!(:feedback) { Feedback.create(summary: "Summary", comment: "No comment.") }


  def update_feedback(options={})
    options[:summary] ||= "My todo list"
    options[:comment] ||= "This is my todo list."

    feedback = options[:feedback]

    visit "/feedbacks"
    within "#feedback_#{feedback.id}" do
      click_link "Edit"
    end

    fill_in "Summary", with: options[:summary]
    fill_in "Comment", with: options[:comment]
    click_button "Update Feedback"
  end

  it "updates a feedback successfully with correct information" do
    update_feedback feedback: feedback,
                     summary: "New summary",
                     comment: "New comment"

    feedback.reload

    expect(page).to have_content("Feedback was successfully updated")
    expect(feedback.summary).to eq("New summary")
    expect(feedback.comment).to eq("New comment")
  end

  it "displays an error with no summary" do
    update_feedback feedback: feedback, summary: ""
    summary = feedback.summary
    feedback.reload
    expect(feedback.summary).to eq(summary)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a summary" do
    update_feedback feedback: feedback, summary: "hi"
    expect(page).to have_content("error")
  end

  it "displays an error with no comment" do
    update_feedback feedback: feedback, comment: ""
    expect(page).to have_content("error")
  end

  it "displays an error with too short a comment" do
    update_feedback feedback: feedback, comment: "hi"
    expect(page).to have_content("error")
  end

end