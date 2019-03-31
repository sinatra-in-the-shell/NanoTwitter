post '/api/tags/?' do
  @tag = Tag.new(
    name: params['name']
  )
  if @tag.save
    json_response 201, nil
  else
    json_response 400, nil, @tag.errors.full_messages
  end
end

get '/api/tags/?' do
  skip = params['skip']
  max_results = params['maxresults']
  @tags = Tag.with_skip(skip).with_max(max_results)
  if @tags
    json_response 200, @tags.to_a
  else
    json_response 404, nil
  end
end

get '/api/tags/trending/?' do
  @tags = Tag.all
  if @tags
    json_response 200, @tags.to_a
  else
    json_response 404, nil
  end
end
