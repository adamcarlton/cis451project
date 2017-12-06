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
  
$query = "SELECT IFNULL(gh.gh_name, 'Not Controlled by Great House') as rulingHouse, r.region_name as controlsRegion, r.region_desc as regionDescription
FROM great_houses gh RIGHT JOIN region r ON (gh.gh_id=r.controlled_by_gh)";

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
    print "$row[rulingHouse],  $row[controlsRegion], $row[regionDescription]";
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