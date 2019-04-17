import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import CssBaseline from '@material-ui/core/CssBaseline';

import Navbar from './general/navbar'
import TweetCollection from './tweet/tweetCollection'
import { nanoAPI } from '../nanoAPI'
import { locationHelper } from '../helpers/location'

const styles = theme => ({
  navbar: {
    position: 'relative',
  },
  profile: {
    width: '100%',
    maxWidth: 400,
  },
  layout: {
    width: 'auto',
    marginTop: theme.spacing.unit * 1,
    marginLeft: theme.spacing.unit * 3,
    marginRight: theme.spacing.unit * 3,
    [theme.breakpoints.up(1800 + theme.spacing.unit * 3 * 2)]: {
      width: 1800,
      marginLeft: 'auto',
      marginRight: 'auto',
    },
  },
  editor: {
    marginTop: 0,
    margin: `${theme.spacing.unit}px auto`,
  },
  tcollection: {
    flexGrow: 1,
  },
});

function Search(props) {

  const { classes } = props;
  const keyword = locationHelper.searchparams().search;

  return (
    <React.Fragment>
      <CssBaseline />
      <Navbar position="static" />
      <main className={classes.layout}>
        <Grid container className={classes.root} spacing={24}>
          <Grid item xs={4} md={4} lg={3}>
          </Grid>

          <Grid item xs={4} md={4} lg={6}>
            <TweetCollection
              className={classes.tcollection}
              sourceAPI={function() {
                return (
                  nanoAPI.search(keyword)
                );
              }}
            />
          </Grid>

          <Grid item xs={4} md={4} lg={3}>
          </Grid>
        </Grid>
      </main>
    </React.Fragment>
  );
}

Search.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(Search);