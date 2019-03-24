function errorHandler(response) {
  if(response.ok) {
    return response.json();
  }
  throw new Error(response.json().errors);
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
      credentials: 'same-origin'
    }).then(errorHandler);
  },

  timeline() {
    return fetch('/api/user/timeline', {
      method: 'GET',
      credentials: 'same-origin'
    }).then(errorHandler);
  },

  userTweets() {

  }
};
