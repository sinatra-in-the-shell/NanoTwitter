export const nanoAPI = {
  signup() {

  },

  login(data, onSuccess, onFail) {
    fetch('/api/login', {
      method: 'POST',
      body: data,
    }).then(
      response => response.status
    ).then(status => {
      if(status===204) {
        onSuccess();
      }else{
        onFail();
      }
    });
  },

  logout(onSuccess, onFail) {
    fetch('/api/logout', {
      method: 'DELETE'
    }).then(
      response => response.status
    ).then(status => {
      if(status===204) {
        onSuccess();
      }else{
        onFail();
      }
    });
  },

  timeline(onSuccess, onFail) {

  },

  userTweets() {

  }
};
