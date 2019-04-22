import React from 'react';
import PropTypes from 'prop-types';
import Button from '@material-ui/core/Button';
import FormControl from '@material-ui/core/FormControl';
import OutlinedInput from '@material-ui/core/OutlinedInput';
import withStyles from '@material-ui/core/styles/withStyles';

const styles = theme => ({
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
    this.state = {text: ""}
    this.handleTextChange = this.handleTextChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    const data = new FormData(event.target);
    const me = this;

    this.props.targetAPI(data)
    .then(function(json) {
      me.setState({text: ""});
      alert('Success');
    })
    .catch(function(error) {
      alert(error.message);
    });
  }

  handleTextChange(event) {
    this.setState({text: event.target.value});
  }

  render() {
    const { classes } = this.props;
    return (
      <form className={classes.form} onSubmit={this.handleSubmit}>
        <FormControl margin="dense" required fullWidth>
          <OutlinedInput
            name="text"
            multiline
            rows="3"
            labelWidth={0}
            placeholder="Tweet comes here"
            className={classes.textField}
            margin="dense"
            value={this.state.text}
            onChange={this.handleTextChange}
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
    );
  }
}

TweetEditor.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(TweetEditor);
