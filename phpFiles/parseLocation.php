<?php

include('connectionData.txt');

$conn = mysqli_connect($server, $user, $pass, $dbname, $port)
or die('Error connecting to MySQL server.');

?>

<html>
<head>
  <title>Database Result</title>
  </head>
  
  <body bgcolor="white">
  
  <hr>
  
  
<?php
  
$input = $_POST['selectForm'];

$query = "SELECT loc.location_name as location, r.region_name as inRegion, loc.location_description
FROM important_location loc JOIN region r USING(region_id)
WHERE loc.location_name = ";

$query = $query."'".$input."';";

?>

<hr>
<p>
Result:
<p>

<?php
$result = mysqli_query($conn, $query)
or die(mysqli_error($conn));

print "<pre>";
while($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {
    print "\n";
    print "$row[location] is in $row[inRegion], $row[loc.location_description]";
  }
print "</pre>";

mysqli_free_result($result);

mysqli_close($conn);

?>

<p>
<hr>

<p>
 
</body>
</html>