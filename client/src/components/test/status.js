import React from 'react';

class Status extends React.Component {
  constructor(props){
    super(props);
    this.state = {
        status: {
          test_id: 0,
          user_count: 0,
          follow_count: 0,
          tweet_count: 0
        }
    }
  }

  componentDidMount() {
    this.fetchData();
  }
  
  fetchData() {
    return fetch('/api/status')
    .then(
      response => response.json()
    ).then(
      json => {
        this.setState({status: json})
      }
    ).catch(
      error => {console.log(error)}
    );
  }

  render() {
    return <ChildComponent {...this.state} />
  }
};

const ChildComponent = (props) => {
  console.log(props)
  return(
    <div>
      <ul>
        <li>Test User ID: {props.status.test_id}</li>
        <li>User Count: {props.status.user_count}</li>
        <li>Follow Count: {props.status.follow_count}</li>
        <li>Tweet Count: {props.status.tweet_count}</li>
      </ul>
    </div>
  );
};

export default Status