function errorHandler(response) {
  return response.json().then(function(json) {
    if(response.ok) {
      return json;
    }
    throw new Error(json.errors);
  });
}

export const nanoAPI = {
  signup(data) {
    return fetch('/api/register', {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  login(data) {
    return fetch('/api/login', {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  logout() {
    return fetch('/api/logout', {
      method: 'DELETE',
      credentials: 'include'
    }).then(errorHandler);
  },

  timeline() {
    return fetch('/api/user/timeline', {
      method: 'GET',
      credentials: 'include'
    }).then(errorHandler);
  },

  userTweets() {

  }
};
