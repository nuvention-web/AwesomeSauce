<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Helm</title>

    <!-- Bootstrap core CSS -->
    <link href="/AwesomeSauce/WebApp/Resources/bootstrap.min.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/AwesomeSauce/WebApp/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="/AwesomeSauce/WebApp/Resources/carousel.css" rel="stylesheet">
  </head>
<body>
<!--
    <div class="navbar-wrapper">
      <div class="container">
        <nav class="navbar navbar-inverse navbar-static-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" runat="server" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="#">RideGuard</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              

                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact Us</a></li>
                <li></li>
                <li><a href="#admin">Admin</a></li>
                
                                  </ul>
                <table align="right">
                    <tr valign="middle" style="padding-top:3pt">
    			<form id="form1">
                        <td style="padding-right:10pt;padding-top:10pt"><input type="text" placeholder="Username" /></td>
                        <td style="padding-right:10pt;padding-top:10pt"><input type="password" placeholder="Password" /></td>
                        <td class="navbar-collapse collapse" style="padding-top:10pt" ><input class="btn btn-sm btn-primary" type="submit" value="login" href="login"></td></form>
                    </tr>
                </table>
           
            </div>
          </div>
        </nav>

      </div>
    </div>
-->

    <!-- Carousel
    ================================================== -->
   <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators"></ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img src="/AwesomeSauce/WebApp/Resources/image2.jpg" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
	    <img src="/AwesomeSauce/WebApp/Resources/helm.png" style="width:100px;height:100px" class="img-circle" id="logo" align="middle">
	      <h1> Helm </h1>
              <p>The mobile app that keeps you safe when getting from one place to another</p>
              <form class="form-inline" id="signup" method="POST" action="index.php/signup_page">
		<div class="form-group">
		  <input class="form-control input-lg " type="text" name="email" placeholder="Enter email">
		</div>
                <button type="submit" class="btn btn-primary btn-lg">Sign up today!</button>
	      </form>      
            </div>
          </div>
        </div>
        </div>
      </div>
   
   </div><!-- /.carousel -->


   

      <!-- START THE FEATURETTES -->
      <div class="container marketing">
	<h2 id="feature-header" align="center">Coming soon to App Store. Check out our features!</h2>
      
      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">Detect Route Deviation</h2>
          <p class="lead">Our app will show how much you deviate from the expected route and alert family and friends when the deviation is too great. Rest assured!</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-rounded" src ="/AwesomeSauce/WebApp/Resources/deviation.png" style="width:450px;height:350px" align="right" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-5">
          <img class="featurette-image img-rounded" src="/AwesomeSauce/WebApp/Resources/tracking.png" style="width:300px;height:500px" alt="Generic placeholder image">
        </div>
        <div class="col-md-7">
          <h2 class="featurette-heading">Real Time Tracking</h2>
          <p class="lead">Our app will allow family and friends to track your position while on the move, and automatically shuts off when you reach the destination. Safe and easy. No violation of privacy.</p>
        </div>
      </div>

<!--
      <hr class="featurette-divider">


      <div class="row featurette">
	<div class="col-md-7">
	  <h2 class="featurette-heading">Panic Button</h2>
	  <p class="lead">In case of emergency, our app has a panic button which will alert your contacts and local authorities</p>
	</div>
	<div class="col-md-5">
	  <img class="featurette-image img-responsive" src="#" style="width:350;height:350px" align="right" alt="Generic placeholder image">
	</div>
      </div>
-->



      <!-- /END THE FEATURETTES -->
      <hr class="featurette-divider">
      
      <h2 id="feature-header" align=center>The Team</h2>
      <div class="row">
	<div class="col-lg-2 col-lg-offset-1">
	  <a href="https://www.linkedin.com/in/albrechtmatthew" target="_blank"><img class="img-circle" src="/AwesomeSauce/WebApp/Resources/matt.jpg" alt="Generic placeholder image" width="140" height="140"></a>
	  <h3>Matt</h3>
        </div>
	<div class="col-lg-2">
	  <a href="https://www.linkedin.com/pub/patr%C3%ADcia-gomes/18/b16/b46" target="_blank"><img class="img-circle" src="/AwesomeSauce/WebApp/Resources/patricia.jpg" alt="Generic placeholder image" width="140" height="140"></a>
	  <h3>Patricia</h3>
	</div>
	<div class="col-lg-2">
	  <a href="https://www.linkedin.com/pub/reshu-goel/a4/405/615" target="_blank"><img class="img-circle" src="/AwesomeSauce/WebApp/Resources/reshu.jpg" alt="Generic placeholder image" width="140" height="140"></a>
	  <h3>Reshu</h3>
	</div>
	<div class="col-lg-2">
	  <a href="https://www.linkedin.com/in/richardliang" target="_blank"><img class="img-circle" src="/AwesomeSauce/WebApp/Resources/richard.jpg" alt="Generic placeholder image" width="140" height="140"></a>
	  <h3>Richard</h3>
	</div>
	<div class="col-lg-2">
          <a href="https://www.linkedin.com/pub/shubham-kumar/92/718/71a" target="_blank"><img class="img-circle" src="/AwesomeSauce/WebApp/Resources/shubham.jpg" alt="Generic placeholder image" width="140" height="140"></a>
          <h3>Shubham</h3>
        </div>
      </div>


      <hr class="featurette-divider">


      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 Helm. Image credit Kalyan Chakravarthy/Flickr <!-- &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p> -->
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="/AwesomeSauce/WebApp/js/bootstrap.min.js"></script>
    <script src="/AwesomeSauce/WebApp/js/docs.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/AwesomeSauce/WebApp/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
    
