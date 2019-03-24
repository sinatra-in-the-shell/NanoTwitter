def json_response status_code, data=nil, errors=nil
  status status_code
  content_type :json
  meta = nil
  res = {
    meta: meta,
    data: data,
    errors: errors
  }.to_json
end
