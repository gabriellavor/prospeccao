<?php
$config['displayErrorDetails'] = true;
$config['addContentLengthHeader'] = false;
$config['prod'] = true;

if($config['prod']){
    //$config['db']['host'] = 'localhost';
    $config['db']['host'] = 'scorelead.com.br';
    
    $config['db']['user'] = 'scorelea_usuario';
    $config['db']['pass'] = 'scorelead';
    $config['db']['dbname'] = 'scorelea_prospeccao';
    $config['settings']['displayErrorDetails'] = true;
    $config['app']['linkedinCallback'] = 'https://scorelead.com.br/home';
    
}else{
    $config['db']['host'] = 'db';
    $config['db']['user'] = 'root';
    //$config['db']['dbname'] = 'prospeccao';
    $config['db']['dbname'] = 'scorelea_prospeccao';
    $config['db']['pass'] = '1234';
    $config['settings']['displayErrorDetails'] = true;
    $config['app']['linkedinCallback'] = 'https://scorelead.com.br/home';
}