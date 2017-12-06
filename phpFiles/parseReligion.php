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
  

$query = "SELECT DISTINCT gh.gh_name as name, IFNULL(r.relig_name, 'Faith of the Seven') as religion, IFNULL(r.relig_desc, 'The majority religion of Westeros. Based on the the worship of a single deity with seven aspects/faces') as religionDescription
FROM great_houses gh LEFT JOIN person_of_interest poi USING(gh_id) LEFT JOIN believes_in USING (poi_id) LEFT JOIN religion r USING (relig_code)";

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
    print "$row[name] in $row[religion] \n$row[religionDescription]\n";
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