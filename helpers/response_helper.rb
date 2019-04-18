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
