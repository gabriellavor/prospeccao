<?php
namespace Api\Controllers;
use Api\Controllers\Controller;

class FacebookController extends Controller{
    public function retornaFacebook($request,$response,$args){
        try {
            header('Access-Control-Allow-Origin: *');
            header('Access-Control-Allow-Methods: GET');
            header('Access-Control-Allow-Headers: token, Content-Type');
            header('Access-Control-Allow-Credential: true');
            header('Content-Type: text/json');
            header('Cache-Control: no-cache');			

            $args['userId'] = '1857880754301141';
            $userId = (int)$args['userId'];
            $app_secret = '';
            $app_id = '';

            $fb = new \Facebook\Facebook([
            'app_id' => $app_id,
            'app_secret' => $app_secret,
            'default_graph_version' => 'v3.1'
            ]);

            $response = $fb->get(
            '/'.$userId.'/?fields=name,first_name,last_name,email,picture',
            '|yv-FCGayR9IrQ8G2_vKI2sCCW04'
            );
        } catch(FacebookExceptionsFacebookResponseException $e) {
            echo 'Graph returned an error: ' . $e->getMessage();
            exit;
        } catch(FacebookExceptionsFacebookSDKException $e) {
            echo 'Facebook SDK returned an error: ' . $e->getMessage();
            exit;
        }
        $graphNode = $response->getGraphNode();
        //var_dump($graphNode);
        $resultado['nome'] = $graphNode->getField('name');
        $resultado['email'] = $graphNode->getField('email');
        $foto = $graphNode->getField('picture');
        $resultado['picture'] = $foto['url'];
        return json_encode($resultado);
    }
    
    public function retornaEmpresa($request,$response,$args){
        try {
            header('Access-Control-Allow-Origin: *');
            header('Access-Control-Allow-Methods: GET');
            header('Access-Control-Allow-Headers: token, Content-Type');
            header('Access-Control-Allow-Credential: true');
            header('Content-Type: text/json');
            header('Cache-Control: no-cache');			

            $fb = new \Facebook\Facebook([
            'app_id' => '',
            'app_secret' => '',
            'default_graph_version' => 'v3.1'
            ]);

            $response = $fb->get(
            '/search?type=place&q=Buonny Projetos e Serviços&center=-23.515234,-46.394716&fields=name,checkins,picture',
            '|yv-FCGayR9IrQ8G2_vKI2sCCW04'
            );
        } catch(FacebookExceptionsFacebookResponseException $e) {
            echo 'Graph returned an error: ' . $e->getMessage();
            exit;
        } catch(FacebookExceptionsFacebookSDKException $e) {
            echo 'Facebook SDK returned an error: ' . $e->getMessage();
            exit;
        }
        $resultado = $response->getGraphEdge()->asArray();
        return json_encode($resultado);
    }
}