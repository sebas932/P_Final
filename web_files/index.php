<?php 
	include("config.php"); 

	include("head.php"); 
	include("header.php"); 
	if($_GET) { 
		 $placa	= $_GET['placa'];
		 if (strlen($placa)==6){
		 	mysql_query("INSERT INTO ingresos (placa) values('$placa')") or die("Error en: $busqueda: " . mysql_error()); 
		 }
	     
         
	exit();	
	} 
?>
	<table class="tablesorter">
		<thead>
			<tr>
				<th>ID Ingreso</th>
				<th>Placa</th>
				<th>Entrada</th>
				<th>Salida</th>
			</tr>
		</thead>
		<tbody>
			 
		
<?php 	
		$result = mysql_query("SELECT * FROM ingresos WHERE 1 ORDER BY idingreso DESC ")or die("Error en: $busqueda: " . mysql_error());;
        while ($row = @mysql_fetch_assoc($result)){    
		    echo '<tr><td>'.$row['idingreso'].'</td><td>'.$row['placa'].'</td><td>'.$row['horaEntrada'].'</td><td>'.$row['horaSalida'].'</td></tr>'; 
        }      
?>
		</tbody>
	</table>

<?php  include("footer.php");  ?>