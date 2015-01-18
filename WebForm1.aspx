<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="All_Cabs.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Carousel Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="Resources/bootstrap.min.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="Resources/carousel.css" rel="stylesheet">
  </head>
<body>
    <form id="form1" runat="server">
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
              <a class="navbar-brand" href="#">AllCabs</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact Us</a></li>
                <li></li>
                <li><a href="#admin">Admin</a></li>
                
                                  </ul>
                <table align="right">
                    <tr valign="middle" style="padding-top:3pt">
                        <td style="padding-right:10pt;padding-top:10pt"><input runat="server" type="text" placeholder="Username" /></td>
                        <td style="padding-right:10pt;padding-top:10pt"><input  runat="server" type="password" placeholder="Password" /></td>
                        <td class="navbar-collapse collapse" style="padding-top:10pt" ><a runat="server" onclick="onclick_link1" href="#">Login</a></td>
                    </tr>
                </table>
                
            </div>
          </div>
        </nav>

      </div>
    </div>


    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>Grab A Ride !</h1>
              <p>Connects you to nearest and cheapest rides from professional drivers. Download Allcabs for iPhone or Android to request your ride with the tap of a button, track your driver’s arrival and pay your fare seamlessly</p>
              <table align="center">
                <tr><td  align="right" style="padding-right: 20px;"><input runat="server" id="textbox1" type="text" style="font-size:19pt;color:black" name="email"  placeholder="email"></td>
                    <%--<td><button runat="server" class="btn btn-lg btn-primary"  onclick="signup() Sign up today</button></td></tr>">--%>
                   <td> <asp:Button ID="Button1" runat="server" class="btn btn-lg btn-primary" Text="Sign up today" OnClick="Button1_Click1" />
                    </td>
              </table>
            </div>
          </div>
        </div>
        </div>
      </div>
   
    </div><!-- /.carousel -->


   

      <!-- START THE FEATURETTES -->
      <div class="container marketing">

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">Fast</h2>
          <p class="lead">We will find you the nearest ride around you.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive" src ="Resources/fast.jpg" style="width:350px;height:250px" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-5">
          <img class="featurette-image img-responsive" src ="Resources/cheap.jpg"  style="width:350px;height:250px" alt="Generic placeholder image">
        </div>
        <div class="col-md-7">
          <h2 class="featurette-heading">Cheap</h2>
          <p class="lead">you will get the cheapest and great experience with your cabs.</p>
        </div>
      </div>

      <!-- /END THE FEATURETTES -->
 <hr class="featurette-divider">

      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 Company, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/docs.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    </form>
  </body>
</html>
    