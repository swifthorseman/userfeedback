json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :summary, :comment
  json.url feedback_url(feedback, format: :json)
end
