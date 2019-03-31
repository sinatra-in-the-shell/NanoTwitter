import React from 'react';
import { withStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Typography from '@material-ui/core/Typography';
import Avatar from '@material-ui/core/Avatar';
import indigo from '@material-ui/core/colors/indigo';
import Grid from '@material-ui/core/Grid';

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
    },
    infobox: {
      marginTop: 10
    },
    link: {
      color: indigo[400]
    }
  });

class Profile extends React.Component {

    render() {
      const { classes } = this.props
      return (
        <Card className={this.props.className}>
          <CardActionArea>
            <CardMedia
              className={classes.media}
              image=""
              title="User banner"
            />
            <CardContent>

              <Grid container spacing={0}>
                <Grid item xs={4} md={4} lg={4}>
                  <Avatar alt="username" src="https://material-ui.com/static/images/avatar/1.jpg" className={this.props.classes.bigAvatar} />
                </Grid>
                <Grid item xs={8} md={8} lg={8}>
                  <Typography variant="title">
                    Fake username
                  </Typography>
                  <Typography gutterBottom variant="caption">
                    Fake displayname
                  </Typography>
                </Grid>
              </Grid>

              <Grid container spacing={8} className={classes.infobox}>
                <Grid item xs={4} md={4} lg={4}>
                  <Typography gutterBottom variant="caption" >
                    Tweets
                  </Typography>
                  <Typography variant="title" className={classes.link} >
                    0
                  </Typography>
                </Grid>
                <Grid item xs={4} md={4} lg={4}>
                  <Typography gutterBottom variant="caption" >
                    Followers
                  </Typography>
                  <Typography variant="title" className={classes.link} >
                    0
                  </Typography>
                </Grid>
                <Grid item xs={4} md={4} lg={4}>
                  <Typography gutterBottom variant="caption" >
                    Following
                  </Typography>
                  <Typography variant="title" className={classes.link}>
                    0
                  </Typography>
                </Grid>

              </Grid>

            </CardContent>
          </CardActionArea>
        </Card>
      );
    }
}

export default withStyles(styles)(Profile);
