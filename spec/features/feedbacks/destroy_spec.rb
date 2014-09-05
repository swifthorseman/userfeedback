require 'spec_helper'

describe "Deleting feedback" do
  let!(:feedback) { Feedback.create(summary: "Good Stuff", comment: "No further comment.") }

  it "is successful when clicking the destroy link" do
    visit "/feedbacks"

    within "#feedback_#{feedback.id}" do
      click_link "Destroy"
    end

    expect(page).to_not have_content(feedback.summary)
    expect(Feedback.count).to eq(0)

  end

end
