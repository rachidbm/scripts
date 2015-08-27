<?php
/**
 * Server(s) configuration
 */
$i = 0;
// The $cfg['Servers'] array starts with $cfg['Servers'][1].  Do not use $cfg['Servers'][0].
// You can disable a server config entry by setting host to ''.
$i++;

// ## Increase session timeout ## 
//ini_set('session.gc_maxlifetime', 3600 * 8);
$cfg['LoginCookieValidity'] = 3600 * 8;

$cfg['Servers'][$i]['auth_type'] = 'config';
$cfg['Servers'][$i]['user'] = 'bla';
$cfg['Servers'][$i]['password'] = 'pw';
