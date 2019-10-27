<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


require 'vendor/autoload.php';
require 'config/config.php';


//require ('vendor/palanik/corsslim/CorsSlim.php');

$app = new \Slim\App(['settings' => $config]);

$container = $app->getContainer();

$container['db'] = function ($c) {
    $db = $c['settings']['db'];
    try{
        $pdo = new PDO("mysql:host=" . $db['host'] . ";port=3306;dbname=" . $db['dbname'],$db['user'], $db['pass']);
        $pdo->exec("set names utf8");
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        return $pdo;
    } catch (PDOException $e) {
        echo $e->getMessage();
    }

    
};

// $container['errorHandler'] = function ($c) {
//     return function ($request, $response, $exception) use ($c) {
//         $statusCode = $exception->getCode() ? $exception->getCode() : 500;
//         return $c['response']->withStatus($statusCode)
//             ->withHeader('Content-Type', 'Application/json')
//             ->withJson(["message" => $exception->getMessage()], $statusCode);
//     };
// };
//Clientes
$container['ClienteController'] = function($container) use ($app){
    return new Api\Controllers\ClienteController($container);
};
$app->post('/cliente','ClienteController:incluirClientes')->setName('cliente');
$app->post('/cliente-upload','ClienteController:upload')->setName('cliente');
$app->get('/cliente','ClienteController:listaClientes')->setName('cliente');
$app->get('/cliente/{id}','ClienteController:listaCliente')->setName('cliente');
$app->get('/cliente_count','ClienteController:countCliente')->setName('cliente');
$app->get('/clientes/{page}/{qtd}','ClienteController:listaClientesPaginate')->setName('cliente');
$app->get('/clientes-cnae','ClienteController:capturarCnae')->setName('cliente');
$app->get('/clientes/termos','ClienteController:gravaTermos')->setName('cliente');


//Usuarios
$container['UsuarioController'] = function($container) use ($app){
    return new Api\Controllers\UsuarioController($container);
};
$app->post('/usuario','UsuarioController:incluirUsuarios')->setName('usuario');
$app->post('/usuario/{id}','UsuarioController:alterarUsuarios')->setName('usuario');
$app->post('/login','UsuarioController:login')->setName('usuario');
$app->get('/usuario_count','UsuarioController:countUsuario')->setName('usuario');
$app->get('/usuarios/{page}/{qtd}','UsuarioController:listaUsuarioPaginate')->setName('usuario');
$app->get('/usuario/{id}','UsuarioController:listaUsuario')->setName('usuario');
$app->get('/usuario-inativar/{id}/{ativo}','UsuarioController:inativarAtivarUsuarios')->setName('usuario');

//Leads
$container['LeadController'] = function($container) use ($app){
    return new Api\Controllers\LeadController($container);
};

$app->post('/lead','LeadController:listaLeads')->setName('lead');
$app->get('/lead','LeadController:listaLeads')->setName('lead');
$app->get('/lead/{id}','LeadController:listaLead')->setName('lead');
$app->get('/lead_count/{estado}/{cidade}/{bairro}','LeadController:countLead')->setName('lead');
$app->get('/leads/{page}/{qtd}/{estado}/{cidade}/{bairro}','LeadController:listaLeadsPaginate')->setName('lead');
$app->get('/retorna_estados','LeadController:retorna_estados')->setName('lead');
$app->get('/retorna_cidades/{estado}','LeadController:retorna_cidades')->setName('lead');
$app->get('/retorna_bairros/{estado}/{cidade}','LeadController:retorna_bairros')->setName('lead');
$app->get('/grafico_ramo_atividade/{ramo}','LeadController:grafico_ramo_atividade')->setName('lead');
$app->get('/grafico_cliente_lead','LeadController:grafico_cliente_lead')->setName('lead');
$app->get('/grafico_porcentagem','LeadController:grafico_porcentagem')->setName('lead');
$app->get('/busca-configuracao','LeadController:buscaConfiguracao')->setName('lead');
$app->get('/configuracao/{porcentagem}','LeadController:configuracao')->setName('lead');
$app->get('/grafico_regiao_estado','LeadController:grafico_regiao_estado')->setName('lead');
$app->get('/grafico_regiao_cidade','LeadController:grafico_regiao_cidade')->setName('lead');
$app->get('/grafico_regiao_bairro','LeadController:grafico_regiao_bairro')->setName('lead');


//Leads
$container['TermoController'] = function($container) use ($app){
    return new Api\Controllers\TermoController($container);
};

$app->get('/termo','TermoController:listaTermos')->setName('termo');
$app->post('/termo','TermoController:incluirTermos')->setName('termo');
$app->get('/termo-excluir/{id}','TermoController:excluirTermos')->setName('termo');
//Facebook
// $container['FacebookController'] = function($container) use ($app){
//     return new Api\Controllers\FacebookController($container);
// };
// $app->get('/facebook/{user_id}','FacebookController:retornaFacebook')->setName('facebook');
// $app->get('/facebook-page','FacebookController:retornaEmpresa')->setName('facebook');

//Linkedin
// $container['LinkedinController'] = function($container) use ($app){
//     return new Api\Controllers\LinkedinController($container);
// };
// $app->get('/linkedin','LinkedinController2:loginLinkedin')->setName('linkedin');
// $app->get('/user-linkedin','LinkedinController:retornaLinkedin')->setName('linkedin');


$app->run();