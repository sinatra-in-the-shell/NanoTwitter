import { sessionHelper } from "./helpers/session"

function errorHandler(response) {
  return response.json().then(function(json) {
    if(response.ok) {
      return json;
    }
    if(response.status==401) {
      return sessionHelper.logout();
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
      method: 'DELETE'
    }).then(errorHandler);
  },

  userProfile(id) {
    return fetch('/api/users/'+id, {
      method: 'GET'
    }).then(errorHandler);
  },

  timeline() {
    return fetch('/api/timeline', {
      method: 'GET'
    }).then(errorHandler);
  },

  userTweets(id) {
    return fetch('/api/users/'+id+'/tweets', {
      method: 'GET'
    }).then(errorHandler);
  },

  postTweets(data) {
    return fetch('/api/tweets', {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },
};
