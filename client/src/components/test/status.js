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
    return fetch('/api/test/status')
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
    const {status} = this.state
    return (
      <div>
        <ul>
          <li>Test User ID: {status.test_id}</li>
          <li>User Count: {status.user_count}</li>
          <li>Follow Count: {status.follow_count}</li>
          <li>Tweet Count: {status.tweet_count}</li>
        </ul>
      </div>
    )
  }
};

export default Status