<?php
if($_POST['username']=="Rakesh" && $_POST['password']=="pai@123") {
	echo("<h2>Welcome ".$_POST['username']."</h2>");
}
else if ($_POST['username']=="Rakesh") {
	echo("<h3>Wrong password!!! Try Again</h3>");
}
else {
	echo("<h3>Wrong username and password</h3>");
}
?>