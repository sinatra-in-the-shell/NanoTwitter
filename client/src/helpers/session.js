import { history } from "../App";

export const sessionHelper = {
  isLoggedIn() {
    if(localStorage.getItem('isLoggedIn')) {
      sessionStorage.setItem('isLoggedIn', true);
    }
    return sessionStorage.getItem('isLoggedIn');
  },

  login(rememberMe) {
    sessionStorage.setItem('isLoggedIn', true);
    if(rememberMe) {
      localStorage.setItem('isLoggedIn', true);
    }
  },

  logout(location = null) {
    sessionStorage.removeItem('isLoggedIn');
    localStorage.removeItem('isLoggedIn');
    history.push({
      pathname: "/login",
      state: { from: location }
    });
  },
};
