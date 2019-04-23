import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import classnames from 'classnames';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Collapse from '@material-ui/core/Collapse';
import Avatar from '@material-ui/core/Avatar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import red from '@material-ui/core/colors/red';
import FavoriteIcon from '@material-ui/icons/Favorite';
import ShareIcon from '@material-ui/icons/Share';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import MoreVertIcon from '@material-ui/icons/MoreVert';

import Link from '../general/link'
import TweetCollection from './tweetCollection'
import TweetEditor from './tweetEditor'
import { nanoAPI } from '../../nanoAPI'

const styles = theme => ({
  media: {
    height: 0,
    paddingTop: '56.25%', // 16:9
  },
  actions: {
    display: 'flex',
  },
  retweeting: {
    fontSize: 14,
  },
  expand: {
    transform: 'rotate(0deg)',
    marginLeft: 'auto',
    transition: theme.transitions.create('transform', {
      duration: theme.transitions.duration.shortest,
    }),
  },
  expandOpen: {
    transform: 'rotate(180deg)',
  },
  avatar: {
    backgroundColor: red[500],
  },
  tcollection: {
    flexGrow: 1,
  },
});

class Tweet extends React.Component {
  constructor(props) {
    super(props);
    this.state = { expanded: false, comments: null };
    this.handleLike = this.handleLike.bind(this);
    this.handleRetweet = this.handleRetweet.bind(this);
  }

  handleExpandClick = () => {
    const { classes } = this.props;

    if(this.state.comments==null) {
      const comments = <TweetCollection
        className={classes.tcollection}
        sourceAPI={()=>nanoAPI.getComments(this.props.tid)}
      />
      this.setState({ comments: comments });
    }
    this.setState(state => ({ expanded: !state.expanded }));
  };

  handleLike = () => {
    nanoAPI.like(this.props.tid)
    .then(function(json) {
      alert('Success');
    })
    .catch(function(error) {
      alert(error.message);
    });
  }

  handleRetweet = () => {
    let id = this.props.tid;
    if(this.props.retweetFrom) {
      id = this.props.retweetFrom.id;
    }

    const data = new FormData();
    data.append('text', this.props.text);

    nanoAPI.postRetweets(id, data)
    .then(function(json) {
      alert('Success');
    })
    .catch(function(error) {
      alert(error.message);
    });
  }

  getHeader = () => {
    const { classes } = this.props;
    if(this.props.retweetFrom){
      const re = this.props.retweetFrom;
      return (
        <div>
          <CardContent>
            <Typography className={classes.retweeting} color="textSecondary" gutterBottom>
              {this.props.userDisplayname+" retweeting"}
            </Typography>
          </CardContent>
          <CardHeader
            avatar={
              <Avatar aria-label="Recipe" className={classes.avatar}>
                {re.display_name[0].toUpperCase()}
              </Avatar>
            }
            action={
              <IconButton>
                <MoreVertIcon />
              </IconButton>
            }
            title={
              <Link to={"/u/"+re.username}>
                {re.display_name}
              </Link>
            }
            subheader={re.created_at}
          />
        </div>
      )
    } else {
      return (
        <CardHeader
          avatar={
            <Avatar aria-label="Recipe" className={classes.avatar}>
              {this.props.userDisplayname[0].toUpperCase()}
            </Avatar>
          }
          action={
            <IconButton>
              <MoreVertIcon />
            </IconButton>
          }
          title={
            <Link to={"/u/"+this.props.username}>
              {this.props.userDisplayname}
            </Link>
          }
          subheader={this.props.createdAt}
        />
      )
    }
  }

  render() {
    const { classes } = this.props;
    const me = this;

    return (
      <Card className={this.props.className} >
        {this.getHeader()}
        <CardContent>
          <Typography component="p">
            {this.props.text}
          </Typography>
        </CardContent>
        <CardActions className={classes.actions} disableActionSpacing>
          <IconButton
            aria-label="Add to favorites"
            onClick={this.handleLike}>
            <FavoriteIcon />
            {this.props.likes}
          </IconButton>
          <IconButton
            aria-label="Share"
            onClick={this.handleRetweet}>
            <ShareIcon />
            {this.props.retweets}
          </IconButton>
          <IconButton
            className={classnames(classes.expand, {
              [classes.expandOpen]: this.state.expanded,
            })}
            onClick={this.handleExpandClick}
            aria-expanded={this.state.expanded}
            aria-label="Show more"
          >
            <ExpandMoreIcon />
          </IconButton>
        </CardActions>
        <Collapse in={this.state.expanded} timeout="auto">
          <CardContent>
            <TweetEditor
              targetAPI={(data)=>nanoAPI.postComments(me.props.tid, data)}
            />
            {this.state.comments}
          </CardContent>
        </Collapse>
      </Card>
    );
  }
}

Tweet.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(Tweet);
