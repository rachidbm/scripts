<?php

/* 	Very dangerous script, do not store on server! 
		Only for temporary usage, delete afterwards!!
*/
 
/*	
	session_start();
	if($_SESSION['isadmin'] != 1) {
	 header("Location: ../");
	}
//*/
	
	$cmd = "";
	if(isset($_POST['cmd'])) {
		$cmd = $_POST['cmd'];
	}
	
	?>
	<title>Test Server Commands</title>
	Voer commando's uit. Bijv. ls
	
	<form action="?" method="post">
		Commando: <input type="text" name="cmd" value="<?=$cmd;?>" style="width:100%;" />
		<br />
		<input type="submit" value="Uitvoeren" />
	</form>
<?

if($cmd != "") {
	?>
	Uitvoer: <br />
	<textarea name="log" id="log" style="height:600px; width:1000px;"><?=system("$cmd");?></textarea>
	
	<script type="text/javascript" language="javascript">
		var t = document.getElementById('log');
		t.scrollTop = t.scrollHeight;
	</script>
	<?
}

?>