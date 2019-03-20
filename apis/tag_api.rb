post '/api/tags' do
  @tag = Tag.new(
    name: params['name']
  )
  if @tag.save
    json_response 201, nil
  else
    json_response 400, nil, @tag.errors.messages
  end
end

get '/api/tags' do
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  @tags = Tag.offset(skip).limit(max_results)
  if @tags
    json_response 200, @tags.to_a
  else
    json_response 404, nil
  end
end

get '/api/tags/trending' do
  @tags = Tag.all
  if @tags
    json_response 200, @tags.to_a
  else
    json_response 404, nil
  end
end
