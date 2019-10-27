<?php
	namespace Api\Controllers;
	use Api\Controllers\Controller;
	class TermoController extends Controller{
		public function listaTermos($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$clientes_sql = $this->db->prepare("SELECT * FROM `termo`");
			$clientes_sql->execute();
			$clientes = $clientes_sql->fetchAll();
			return $response->withJson($clientes, 200);
        }
        
        public function excluirTermos($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
            header('Cache-Control: no-cache');		
			$id = (int)$args['id'];	
			
            if(!empty($id)){
                $termos_sql = $this->db->prepare("DELETE FROM `termo` WHERE term_codigo = ".$id);
                $termos_sql->execute();
                return $response->withJson(['sucesso'=> true], 200);
            }else{
				return $response->withJson(['sucesso'=> false], 200);
            }
			
        }
        
		public function incluirTermos($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$dados = $request->getParsedBody();
			if(!empty($dados['descricao'])){
				$sql = "INSERT INTO termo (term_descricao)
					VALUES (:term_descricao )";
				$sth = $this->db->prepare($sql);
				
				$sth->bindParam("term_descricao",$dados['descricao']);
				$sth->execute();
				$resultado = ['sucesso' => true,'mensagem'=> ''];
				return json_encode($resultado);
			}else{
				$resultado = ['sucesso' => false,"mensagem"=>"Descrição obrigatória"];
				return json_encode($resultado);
			}
		
		}
		
	}