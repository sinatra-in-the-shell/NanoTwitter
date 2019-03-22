export const sessionHelper = {
  isLoggedIn() {
    return localStorage.getItem('isLoggedIn');
  },
  login() {
    localStorage.setItem('isLoggedIn', true);
  },
  logout() {
    localStorage.removeItem('isLoggedIn');
  }
};
