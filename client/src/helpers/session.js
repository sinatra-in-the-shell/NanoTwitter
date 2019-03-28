export const sessionHelper = {
  isLoggedIn() {
    if(localStorage.getItem('isLoggedIn')) {
      sessionStorage.setItem('isLoggedIn');
    }
    return sessionStorage.getItem('isLoggedIn');
  },
  login(rememberMe) {
    sessionStorage.setItem('isLoggedIn', true);
    if(rememberMe) {
      localStorage.setItem('isLoggedIn', true);
    }
  },
  logout() {
    sessionStorage.removeItem('isLoggedIn');
    localStorage.removeItem('isLoggedIn');
  }
};
