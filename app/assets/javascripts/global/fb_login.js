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
  $("#signin").click(function(){
    console.log("signin!");
    
    FB.getLoginStatus(function(response) {
      if (response.status === 'connected') {
        console.log("connected!");
        login();
      } else if (response.status === 'not_authorized') {
        console.log("not authorized!");
        login();
      } else {
        console.log("not logged in!");
        login();
      }
    });
  });

  $("#signout").click(function(){
    console.log("signout!");
    return window.location = '/signout';
  });
};

function login(){
  FB.login(function(response) {
    if (response.authResponse) {
      console.log('Welcome!  Fetching your information.... ');
      FB.api('/me', function(response) {
        console.log('Good to see you, ' + response.name + '.');
        // window.location = '/auth/facebook/callback';
        return window.location = '/auth/facebook/callback';
      });
    } else {
      var msg = 'User cancelled login or did not fully authorize.';
      console.log(msg);
      return window.location = '/signout?msg='+msg;
    }
  }); 
}

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