window.fbAsyncInit = function() {
  // init the FB JS SDK
  FB.init({
    appId      : '425284464187683', // App ID from the App Dashboard
    channelUrl : './channel.html', // Channel File for x-domain communication
    status     : false, // check the login status upon init?
    cookie     : true, // set sessions cookies to allow your server to access the session?
    xfbml      : true  // parse XFBML tags on this page?
  });

  // Additional initialization code such as adding Event Listeners goes here
  $(".facebook-login").click(function(){
    FB.login(function(response) {
      if (response.authResponse) {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
          console.log('Good to see you, ' + response.name + '.');
          // window.location = '/auth/facebook/callback';
          // return '/auth/facebook/callback';
        });
      } else {
        console.log('User cancelled login or did not fully authorize.');
        return window.location = '/signout'
      }
    }); 
  });
};

// Load the SDK's source Asynchronously
// Note that the debug version is being actively developed and might 
// contain some type checks that are overly strict. 
// Please report such bugs using the bugs tool.
(function(d, debug){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = window.location.protocol + "//connect.facebook.net/en_US/all" + (debug ? "/debug" : "") + ".js";
    ref.parentNode.insertBefore(js, ref);
 }(document, /*debug*/ false));