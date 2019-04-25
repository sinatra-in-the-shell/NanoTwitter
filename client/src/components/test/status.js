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
    console.log(this.state.status)
    const {data} = this.state.status
    console.log(data)
    return (
      <div>
        <ul>
          <li>Test User ID: {data.test_id}</li>
          <li>User Count: {data.user_count}</li>
          <li>Follow Count: {data.follow_count}</li>
          <li>Tweet Count: {data.tweet_count}</li>
        </ul>
      </div>
    )
  }
};

export default Status