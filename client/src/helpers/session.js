export const sessionHelper = {
  isLoggedIn() {
    return sessionStorage.getItem('isLoggedIn');
  },
  login() {
    sessionStorage.setItem('isLoggedIn', true);
  },
  logout() {
    sessionStorage.removeItem('isLoggedIn');
  }
};
