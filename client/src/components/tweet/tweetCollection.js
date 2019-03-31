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

function TweetCollection(props) {
  const { classes } = props;

  return (
    <div className={props.className}>
      <Tweet className={classes.paper} />
      <Tweet className={classes.paper} />
      <Tweet className={classes.paper} />
    </div>
  );
}

TweetCollection.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(TweetCollection);
