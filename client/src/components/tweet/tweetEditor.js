import React from 'react';
import PropTypes from 'prop-types';
import Button from '@material-ui/core/Button';
import FormControl from '@material-ui/core/FormControl';
import OutlinedInput from '@material-ui/core/OutlinedInput';
import Paper from '@material-ui/core/Paper';
import withStyles from '@material-ui/core/styles/withStyles';

import { Redirect } from 'react-router'
import { sessionHelper } from '../../helpers/session'
import { nanoAPI } from '../../nanoAPI'

const styles = theme => ({
  main: {
    width: 'auto',
    display: 'block', // Fix IE 11 issue.
    marginLeft: theme.spacing.unit * 3,
    marginRight: theme.spacing.unit * 3,
    [theme.breakpoints.up(400 + theme.spacing.unit * 3 * 2)]: {
      width: 400,
      marginLeft: 'auto',
      marginRight: 'auto',
    },
  },
  paper: {
    marginTop: theme.spacing.unit * 8,
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    padding: `${theme.spacing.unit * 2}px ${theme.spacing.unit * 3}px ${theme.spacing.unit * 3}px`,
  },
  textField: {
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    padding: `${theme.spacing.unit * 2}px`,
  },
  buttons: {
    display: 'flex',
    justifyContent: 'flex-end',
  },
  submit: {
    marginTop: theme.spacing.unit,
    marginLeft: theme.spacing.unit,
  },
});

class TweetEditor extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    const data = new FormData(event.target);
    const me = this;


  }

  render() {
    const { classes } = this.props;
    return (
      <Paper className={this.props.className} >
        <form className={classes.form} onSubmit={this.handleSubmit}>
          <FormControl margin="normal" required fullWidth>
            <OutlinedInput
              name="content"
              multiline
              rows="3"
              placeholder="Tweet comes here"
              className={classes.textField}
              margin="normal"
            />
          </FormControl>
          <div className={classes.buttons} >
            <Button
              type="submit"
              variant="contained"
              color="primary"
              className={classes.submit}
            >
              Post
            </Button>
          </div>
        </form>
      </Paper>
    );
  }
}

TweetEditor.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(TweetEditor);
