import { history } from "../App";
import { locationHelper } from "./location"

export const sessionHelper = {
  isLoggedIn() {
    if(locationHelper.searchparams().test_user) {
      return true;
    }
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
      state: { from: history.location }
    });
  },
};
