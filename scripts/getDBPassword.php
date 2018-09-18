<?php
error_reporting(0);
define( 'MEDIAWIKI', true );
try {
  require_once(__DIR__.'/../mediawiki/LocalSettings.php');
} catch(Error $e) {}
echo $wgDBpassword;
