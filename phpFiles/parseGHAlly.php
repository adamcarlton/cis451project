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
  
$query = "SELECT gh1.gh_name as greatHouse, IFNULL(gh2.gh_name, 'Owes no allegiance') as owesAllegianceTo
FROM great_houses gh1 LEFT JOIN great_house_allegiance gha USING(gh_id) LEFT JOIN great_houses gh2 ON gha.gh_ally_id=gh2.gh_id";

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
    print "$row[greatHouse],  $row[owesAllegianceTo]";
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