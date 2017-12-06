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

$query = "SELECT CONCAT(poi.poi_fname, ' ', poi.poi_lname) as fullName, IFNULL(poi.poi_age, 'Age at death unknown') as age, imd.death_description as deathDescription
FROM person_of_interest poi JOIN important_deaths imd USING(poi_id)
WHERE poi.poi_fname = ";

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
    print "$row[fullName],  $row[age], $row[deathDescription]";
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