import { sessionHelper } from "./helpers/session"
import { locationHelper } from "./helpers/location";

function errorHandler(response) {
  return response.json().then(function(json) {
    if(response.ok) {
      return json;
    }
    if(response.status===401) {
      return sessionHelper.logout();
    }
    throw new Error(json.errors);
  });
}

function testify(url) {
  let test = locationHelper.searchparams().test_user;
  if(test) {
    url = url+'?test_user='+test;
  }
  return url;
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

  userProfile(username) {
    return fetch(testify('/api/users/'+username), {
      method: 'GET'
    }).then(errorHandler);
  },

  timeline() {
    return fetch(testify('/api/timeline'), {
      method: 'GET'
    }).then(errorHandler);
  },

  userTweets(username) {
    return fetch(testify('/api/users/'+username+'/tweets'), {
      method: 'GET'
    }).then(errorHandler);
  },

  getComments(id) {
    return fetch(testify('/api/tweets/'+id+'/comments'), {
      method: 'GET'
    }).then(errorHandler);
  },

  postTweets(data) {
    data.append('tweet_type', 'orig');
    return fetch(testify('/api/tweets'), {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  postComments(id, data) {
    data.append('comment_to_id', id);
    data.append('tweet_type', 'comm');
    return fetch(testify('/api/tweets'), {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  postRetweets(id, data) {
    data.append('retweet_from_id', id);
    data.append('tweet_type', 'retw');
    return fetch(testify('/api/tweets'), {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  like(id) {
    const data = new FormData();
    data.append('tweet_id', id);
    return fetch(testify('/api/likes'), {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  followings() {
    return fetch(testify('/api/follows/followings'), {
      method: 'GET'
    }).then(errorHandler);
  },

  follow(id) {
    const data = new FormData();
    data.append('to_user_id', id);
    return fetch(testify('/api/follows'), {
      method: 'POST',
      body: data,
    }).then(errorHandler);
  },

  unfollow(id) {
    const data = new FormData();
    data.append('to_user_id', id);
    return fetch(testify('/api/follows'), {
      method: 'DELETE',
      body: data,
    }).then(errorHandler);
  },

  search(keyword) {
    let url = '/api/search/tweets?keyword='+keyword+'&maxresults=50'
    let test = locationHelper.searchparams().test_user;
    if(test) {
      url = url+'&test_user='+test;
    }
    return fetch(url, {
      method: 'GET'
    }).then(errorHandler);
  },
};
