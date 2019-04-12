import { history } from "../App";

export const locationHelper = {

  pathparams() {
    return history.location.pathname.split('/');
  },

  lastPathparam() {
    return this.pathparams().slice(-1)[0];
  },

  searchparams() {
    const params =
    history.location.search
    .substr(1)
    .split('&')
    .map(p => p.split('='));
    return Object.assign(
      ...params.map(p => ({[p[0]]: p[1]}))
    );
  },
};
