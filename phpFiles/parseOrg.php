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
$input = mysqli_real_escape_string($conn, $input);

$query = "SELECT org.org_name as organization, org.org_desc as organizationDescription, loc.location_name as location, r.region_name as region
FROM organization org JOIN important_location loc USING(location_id) JOIN region r USING(region_id)
WHERE org.org_name LIKE ";

$query = $query.'"'.$input.'";';
print $query;

?>

<hr>
<p>
Result:
<p>

<?php
$result = mysqli_query($conn, $query)
or die(mysqli_error($conn));

print "<pre style='white-space: pre-wrap; word-break: keep-all;'>";
while($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {
    print "\n";
    print "$row[organization],  $row[organizationDescription] in $row[location] in region $row[region]";
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