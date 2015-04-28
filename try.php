<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <title></title>
  <meta name="Generator" content="Cocoa HTML Writer">
  <meta name="CocoaVersion" content="1343.16">
  <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; line-height: 16.0px; font: 12.0px 'Helvetica Neue'; -webkit-text-stroke: #000000}
    span.s1 {font-kerning: none}
  </style>
</head>
<body>
<p class="p1"><span class="s1">&lt;?php</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// Create connection</span></p>
<p class="p1"><span class="s1">$con=mysqli_connect("localhost”,"db_user”,"AllCabsPassword”,”helm_app");</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// Check connection</span></p>
<p class="p1"><span class="s1">if (mysqli_connect_errno())</span></p>
<p class="p1"><span class="s1">{</span></p>
<p class="p1"><span class="s1">  echo "Failed to connect to MySQL: " .mysqli_connect_error();</span></p>
<p class="p1"><span class="s1">}</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// This SQL statement selects ALL from the table 'Locations'</span></p>
<p class="p1"><span class="s1">$sql = "SELECT * FROM location_tracker";</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// Check if there are results</span></p>
<p class="p1"><span class="s1">if ($result = mysqli_query($con, $sql))</span></p>
<p class="p1"><span class="s1">{</span></p>
<p class="p1"><span class="s1">// If so, then create a results array and a temporary one</span></p>
<p class="p1"><span class="s1">// to hold the data</span></p>
<p class="p1"><span class="s1">$resultArray = array();</span></p>
<p class="p1"><span class="s1">$tempArray = array();</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// Loop through each row in the result set</span></p>
<p class="p1"><span class="s1">while($row = $result-&gt;fetch_object())</span></p>
<p class="p1"><span class="s1">{</span></p>
<p class="p1"><span class="s1">// Add each row into our results array</span></p>
<p class="p1"><span class="s1">$tempArray = $row;</span></p>
<p class="p1"><span class="s1">    array_push($resultArray, $tempArray);</span></p>
<p class="p1"><span class="s1">}</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// Finally, encode the array to JSON and output the results</span></p>
<p class="p1"><span class="s1">echo json_encode($resultArray);</span></p>
<p class="p1"><span class="s1">}</span></p>
<p class="p1"><span class="s1"> </span></p>
<p class="p1"><span class="s1">// Close connections</span></p>
<p class="p1"><span class="s1">mysqli_close($con);</span></p>
<p class="p1"><span class="s1">?&gt;</span></p>
</body>
</html>
