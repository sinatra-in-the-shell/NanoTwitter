import React from 'react';
import PropTypes from 'prop-types';
import Paper from '@material-ui/core/Paper';
import { withStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import Avatar from '@material-ui/core/Avatar';
import Typography from '@material-ui/core/Typography';

import Tweet from './tweet'

const styles = theme => ({
  root: {
    flexGrow: 1,
    overflow: 'hidden',
    padding: `0 ${theme.spacing.unit * 3}px`,
  },
  paper: {
    margin: `${theme.spacing.unit}px auto`,
    padding: theme.spacing.unit * 2,
  },
});

class TweetCollection extends React.Component {
  constructor(props) {
    super(props);
    this.state = { tweets: [] };
    this.fetchTweets();
  }

  fetchTweets() {
    const sourceAPI = this.props.sourceAPI;
    const { classes } = this.props;
    const me = this;

    sourceAPI()
    .then(function(json) {
      let tweets = json.data.map(function(tweet) {
        return (
          <Tweet
            className={classes.paper}
            text={tweet.text}
            userDisplayname={tweet.user.display_name}
            createdAt={tweet.created_at}
          />
        )
      });
      me.setState({ tweets: tweets });
    })
    .catch(function(error) {
      alert(error.message);
    });
  }

  render() {
    const { classes } = this.props;

    return (
      <div className={this.props.className}>
        {this.state.tweets}
      </div>
    );
  };
}

TweetCollection.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(TweetCollection);
