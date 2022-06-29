import React from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';

import { Trans } from 'react-i18next';

import { withStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';

import ResponsiveDialog from './ResponsiveDialog';
import Logo from '../images/app-icon.svg';
import Loading from './Loading';
import LocaleSelect from './LocaleSelect';

const styles = theme => ({
  root: {
    display: 'flex',
    flex: 1,
  },
  content: {
    position: 'relative',
    width: '100%'
  },
  actions: {
    marginTop: -40,
    justifyContent: 'flex-start',
    paddingLeft: theme.spacing(3),
    paddingRight: theme.spacing(3)
  },
  wrapper: {
    width: '100%',
    maxWidth: 300,
    display: 'flex',
    flex: 1,
    alignItems: 'center'
  }
});

const ResponsiveScreen = (props) => {
  const {
    classes,
    withoutLogo,
    withoutPadding,
    loading,
    branding,
    children,
    className,
    DialogProps,
    PaperProps,
    ...other
  } = props;

  const bannerLogoSrc = branding?.bannerLogo ? branding.bannerLogo : Logo;
  const logo = withoutLogo ? null :
    <img src={process.env.PUBLIC_URL + '/static/logo.svg'} className="oc-logo" alt="ownCloud Logo"/>;

  const content = loading ? <Loading/> : (withoutPadding ? children : <DialogContent>{children}</DialogContent>);

  return (
    <Grid container justifyContent="center" alignItems="center" direction="column" spacing={0}
      className={classNames(classes.root, className)} {...other}>
        <div className={classes.wrapper}>
            <div className={classes.content}>
              {logo}
              {content}
            </div>
        </div>
        <footer className="oc-footer-message">
              <Trans i18nKey="konnect.footer.slogan"><strong>ownCloud</strong> - a safe home for all your data</Trans>
        </footer>
    </Grid>
  );
};

ResponsiveScreen.defaultProps = {
  withoutLogo: false,
  withoutPadding: false,
  loading: false
};

ResponsiveScreen.propTypes = {
  classes: PropTypes.object.isRequired,
  withoutLogo: PropTypes.bool,
  withoutPadding: PropTypes.bool,
  loading: PropTypes.bool,
  branding: PropTypes.object,
  children: PropTypes.node.isRequired,
  className: PropTypes.string,
  PaperProps: PropTypes.object,
  DialogProps: PropTypes.object
};

export default withStyles(styles)(ResponsiveScreen);
