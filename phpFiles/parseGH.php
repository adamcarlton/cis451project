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

$query = "SELECT CONCAT(poi.poi_fname, ' ', IFNULL(poi.poi_lname, '')) as fullName, IFNULL(poi.poi_age, 'Age Unknown') as age, IFNULL(poi.poi_titles, 'No Titles') as titles, gh.gh_name as great_house
FROM person_of_interest poi LEFT JOIN great_houses gh USING(gh_id) LEFT JOIN organization org USING (org_id) 
WHERE gh.gh_name = ";

$query = $query."'".$input."';";

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
    print "$row[fullName],  $row[age], $row[great_house], $row[organization], \n$row[titles]\n";
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