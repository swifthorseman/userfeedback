json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :comment
  json.url feedback_url(feedback, format: :json)
end
