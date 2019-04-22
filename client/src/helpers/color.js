import {
  red, pink, purple, deepPurple,
  indigo, blue, lightBlue, cyan,
  teal, green, lightGreen, lime,
  yellow, amber, orange, deepOrange,
  grey
} from '@material-ui/core/colors/';

export const colorHelper = {

  getColor(str) {
    let res = grey[500];
    switch(str.charCodeAt(0)%16) {
      case 0:
        res = red[500];
        break;
      case 1:
        res = pink[500];
        break;
      case 2:
        res = purple[500];
        break;
      case 3:
        res = deepPurple[500];
        break;
      case 4:
        res = indigo[500];
        break;
      case 5:
        res = blue[500];
        break;
      case 6:
        res = lightBlue[500];
        break;
      case 7:
        res = cyan[500];
        break;
      case 8:
        res = teal[500];
        break;
      case 9:
        res = green[500];
        break;
      case 10:
        res = lightGreen[500];
        break;
      case 11:
        res = lime[500];
        break;
      case 12:
        res = yellow[500];
        break;
      case 13:
        res = amber[500];
        break;
      case 14:
        res = orange[500];
        break;
      case 15:
        res = deepOrange[500];
        break;
      default:
        res = grey[500];
    }
    return res;
  },
};
