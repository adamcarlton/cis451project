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

$query = "SELECT CONCAT(poi.poi_fname, ' ', poi.poi_lname) as fullName, IFNULL(poi.poi_age, 'Age Unknown') as age, 
			IFNULL(poi.poi_titles, 'No Titles') as titles, IFNULL(IFNULL(gh.gh_name, lh.lh_name), 'Doesn\'t belong to a house') as house, org.org_name as organization, r.relig_name as religion
FROM person_of_interest as poi LEFT JOIN great_houses as gh USING(gh_id) LEFT JOIN lesser_house lh USING(lh_id) LEFT JOIN organization as org USING (org_id) 
JOIN believes_in USING(poi_id) JOIN religion r USING(relig_code)
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
    print "$row[fullName]  $row[age] \n$row[titles] \n$row[house], $row[organization], $row[religion]";
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