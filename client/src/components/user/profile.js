import React from 'react';
import { withStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Typography from '@material-ui/core/Typography';
import Avatar from '@material-ui/core/Avatar';
import indigo from '@material-ui/core/colors/indigo';
import red from '@material-ui/core/colors/red';
import Grid from '@material-ui/core/Grid';

import Link from '../general/link'
import { nanoAPI } from '../../nanoAPI'
import { colorHelper } from '../../helpers/color'

const styles = theme => ({
    media: {
      height: 110,
      backgroundColor: indigo[500],
    },
    bigAvatar: {
      marginTop: -53,
      width: 75,
      height: 75,
      border: '3px solid #ffffff',
      backgroundColor: red[500],
    },
    infobox: {
      marginTop: 10
    },
    link: {
      color: indigo[400],
    }
  });

class Profile extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      userid: "Loading",
      username: "Loading",
      displayname: "Loading",
      tweets: "Loading",
      followers: "Loading",
      followings: "Loading",
      followed: "Loading",
    };

    this.fetchProfile = this.fetchProfile.bind(this);
    this.checkFollow = this.checkFollow.bind(this);
    this.handleFollow = this.handleFollow.bind(this);
  }

  componentDidMount() {
    this.fetchProfile();
  }

  fetchProfile() {
    const userProfile = this.props.sourceAPI;
    const me = this;

    userProfile(this.props.username)
    .then(function(json) {
      let user = json.data
      me.setState({
        userid: user.id,
        username: user.username,
        displayname: user.display_name,
        tweets: user.tweet_number,
        followers: user.follower_number,
        followings: user.following_number,
      });
      me.checkFollow(me.state.userid);
    })
    .catch(function(error) {
      alert(error.message);
    });
  }

  checkFollow(id) {
    const me = this;
    nanoAPI.followings()
    .then(function(json) {
      let followings = json.data.map(u=>u.id);
      if(followings.includes(id)) {
        me.setState({followed: true});
      } else {
        me.setState({followed: false});
      }
    })
    .catch(function(error) {
      if(error.message==="not found") {
        me.setState({followed: false});
      } else {
        alert(error.message);
      }
    });
  }

  handleFollow() {
    const me = this;
    if(me.state.followed) {
      nanoAPI.unfollow(me.state.userid)
      .then(function(json) {
        me.setState({followed: false});
      })
      .catch(function(error) {
        alert(error.message);
      });
    } else {
      nanoAPI.follow(me.state.userid)
      .then(function(json) {
        me.setState({followed: true});
      })
      .catch(function(error) {
        alert(error.message);
      });
    }
  }

  render() {
    const { classes } = this.props;

    let followButton;
    if(this.state.followed==="Loading") {
      followButton =
      <Button variant="contained" color="primary" disabled className={classes.button}>
        Loading
      </Button>;
    } else {
      followButton =
      <Button
        variant="contained"
        color="primary"
        onClick={this.handleFollow}
        className={classes.button}>
        {this.state.followed ? "Unfollow" : "Follow"}
      </Button>;
    }
    return (
      <Card className={this.props.className}>
        <CardContent
          className={classes.media}
          title="User banner"
        />
        <CardContent>

          <Grid container spacing={0}>
            <Grid item xs={4} md={4} lg={4}>
              <Avatar
                alt={this.state.displayname}
                className={this.props.classes.bigAvatar}>
                {this.state.displayname[0].toUpperCase()}
              </Avatar>
            </Grid>
            <Grid item xs={4} md={4} lg={4}>
              <Typography variant="title">
                <Link to={"/u/"+this.state.username}>
                  {this.state.displayname}
                </Link>
              </Typography>
              <Typography gutterBottom variant="caption">
                <Link to={"/u/"+this.state.username}>
                  {this.state.username}
                </Link>
              </Typography>
            </Grid>
            <Grid item xs={2} md={2} lg={2}>
              {followButton}
            </Grid>
          </Grid>

          <Grid container spacing={8} className={classes.infobox}>
            <Grid item xs={4} md={4} lg={4}>
              <Typography gutterBottom variant="caption" >
                Tweets
              </Typography>
              <Typography variant="title" className={classes.link} >
                {this.state.tweets}
              </Typography>
            </Grid>
            <Grid item xs={4} md={4} lg={4}>
              <Typography gutterBottom variant="caption" >
                Followers
              </Typography>
              <Typography variant="title" className={classes.link} >
                {this.state.followers}
              </Typography>
            </Grid>
            <Grid item xs={4} md={4} lg={4}>
              <Typography gutterBottom variant="caption" >
                Following
              </Typography>
              <Typography variant="title" className={classes.link}>
                {this.state.followings}
              </Typography>
            </Grid>

          </Grid>

        </CardContent>
      </Card>
    );
  }
}

export default withStyles(styles)(Profile);
