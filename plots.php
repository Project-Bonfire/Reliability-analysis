<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Reliability-Analysis Plots</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" crossorigin="anonymous">
  </head>
  <body>
<script type="text/javascript">
  window.onload = function() {
    window.router = ""
    window.figure = ""
    window.onchange = function(){
      console.log("switching to:"+window.router+'/'+window.figure)
      $(".gardenimage").hide()
      console.log($("#"+window.router+" ."+window.figure))
      $("#"+window.router+" ."+window.figure).show()
    }
  };
 
</script>
<style>
.collapsing {
  -webkit-transition: all .1s ease-out;
  -o-transition: all .1s ease-out;
  transition: all .1s ease-out;
}
</style>
  <?php

$dirname = "./";
$dirs = array_filter(glob('*'), 'is_dir');
?>
<div class="btn-group" id="routerbtns" role="group">
<?php
#collect routers
foreach ($dirs as $dir){
  ?>
  <button class="btn btn-secondary routerbutton"  type="button" onclick="window.router='<?php echo $dir;?>';window.onchange()">
    <?php echo $dir?>
  </button>
  <?php
}
?>
 </div>

 <div id="routerfigs">
 <br>
  <?php

#figureButtons
#collect all figure buttons
$arr = array();
foreach ($dirs as $dir){
  #data-toggle="collapse" data-target="#demo"
  $images = glob($dirname.'/'.$dir."/*.png"); 
  foreach($images as $image) {
      $text = basename($image,'.png');
      array_push($arr,$text);
  }
}
#each figure name only once
$arr = array_unique($arr);
$i = 0;
foreach($arr as $name){
  $i++;
  ?>
<button class="btn btn-primary"  type="button" onclick="window.figure='<?php echo $name;?>';window.onchange()"> <?php echo $i.': '.$name?>  </button>
<?php
}

#Images
foreach ($dirs as $dir){
  #data-toggle="collapse" data-target="#demo"
  $images = glob($dirname.'/'.$dir."/*.png");
  echo '<div id="'.$dir.'">';
  foreach($images as $image) {
    $text = basename($image,'.png');
      echo "<li class='".str_replace('/','-',$text)." collapse gardenimage'>\n";
      echo file_get_contents(getcwd().'/'.$dir.'/'.$text.'.txt');	
      echo '<br>';
      echo '<img src="'.$image.'" /><br />';
      echo "</li>\n";
      echo "\n";
  }
  echo "</div>\n";
  
}
?>
<div>



    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"  crossorigin="anonymous"></script>
  </body>
</html>
