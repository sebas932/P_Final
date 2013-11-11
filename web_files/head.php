<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="refresh" content="3">
	<title>Base de datos de parqueadero</title>

	
	<!-- jQuery: required (tablesorter works with jQuery 1.2.3+) -->
	<script src="bower_components/jquery/jquery.min.js"></script>

	<!-- Pick a theme, load the plugin & initialize plugin -->
	<link href="bower_components/tablesorter/css/theme.default.css" rel="stylesheet">
	<script src="bower_components/tablesorter/js/jquery.tablesorter.min.js"></script>
	<!-- <script src="bower_components/tablesorter/js/jquery.tablesorter.widgets.min.js"></script> -->
	<script>
	$(function(){
		$('table').tablesorter({
			widgets        : ['zebra', 'columns'],
			usNumberFormat : false,
			sortReset      : true,
			sortRestart    : true
		});
	});
	</script>
	<!-- Demo styling -->
	 <link href="css/style.css" rel="stylesheet">
</head>