def json_response status_code, data=nil, errors=nil
  status status_code
  content_type :json
  if status_code < 400
    expires 5
  end
  meta = { time: Time.now }
  res = {
    meta: meta,
    data: data,
    errors: errors
  }.to_json
end

def json_array_response(db_result)
  if db_result
    json_response 200, db_result.to_a
  else
    json_response 404, db_result.error.full_messages
  end
end