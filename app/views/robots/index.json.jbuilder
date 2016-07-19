json.array!(@robots) do |robot|
  json.extract! robot, :id
  json.url robot_url(robot, format: :json)
end
