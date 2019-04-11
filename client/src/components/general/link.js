import React from 'react';

import { history } from "../../App";

function Link(props) {
  return (
    <span onClick={()=>history.push(props.to)}>
      {props.children}
    </span>
  )
}

export default Link;
