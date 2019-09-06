<?php
error_reporting(0);
define( 'MEDIAWIKI', true );
try {
  require_once(__DIR__.'/../xbxb/LocalSettings.php');
} catch(Error $e) {}
echo $wgDBpassword;
