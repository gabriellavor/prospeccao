<?php
	namespace Api\Controllers;
	use Api\Controllers\Controller;
	use PDO;
	class UsuarioController extends Controller{
		
		public function login($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');
			$dados = $request->getParsedBody();

			$senha = base64_encode($dados['senha']);
			
			if(!empty($dados['email']) && !empty($dados['senha'])){
				$sql = "SELECT * FROM `usuario` WHERE `usua_email` = '".$dados['email']."' AND `usua_senha` = '".$senha."'";
				$clientes_sql = $this->db->prepare($sql);
				$clientes_sql->execute();
				$clientes = $clientes_sql->fetch();	
				if(!empty($clientes)){
					$resultado = ['sucesso' => true,'usuario' => $clientes['usua_codigo']];	
				}else{
					$resultado = ['sucesso' => false];	
				}
			}else{
				$resultado = ['sucesso' => false];
			}
			return json_encode($resultado);
        }
        
        public function listaUsuarioPaginate($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = array();
			
			$qtd = (int)$args['qtd'];
			$page = ((int)$args['page'] - 1) * $qtd;
			$leads_sql = $this->db->prepare("SELECT usua_codigo,usua_nome,usua_ativo,usua_admin,usua_email FROM `usuario` limit $page,$qtd");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;
        }
        
        public function countUsuario($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = array();
			$leads_sql = $this->db->prepare("SELECT count(*) as total FROM `usuario`");
			$leads_sql->execute();
			$leads = $leads_sql->fetch();
			$retorno = json_encode($leads);
			return $retorno;
		}

		public function listaUsuario($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = [];
			$id = (int)$args['id'];
			if($id > 0){
			
				$query = "SELECT usua_codigo,usua_nome,usua_ativo,usua_admin,usua_email,usua_senha FROM `usuario` 
				where `usua_codigo` = ".$id;
				$usuario_sql = $this->db->prepare($query);
				$usuario_sql->execute();
				$usuario = $usuario_sql->fetch();
				$retorno = json_encode($usuario);
			}

			return $retorno;
		}

		public function incluirUsuarios($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$dados = $request->getParsedBody();
			if(!empty($dados['nome']) && !empty($dados['email']) && !empty($dados['senha'])){

				$query = "SELECT usua_email FROM `usuario` 
				where `usua_email` = '".$dados['email']."'";
				$usuario_sql = $this->db->prepare($query);
				$usuario_sql->execute();
				$usuario = $usuario_sql->fetch();

				if(!empty($usuario)){
					$resultado = ['sucesso' => false,"mensagem"=>"E-Mail já existe, Favor informar outro"];
					return json_encode($resultado);
				}else{
					$sql = "INSERT INTO usuario (usua_nome,usua_email,usua_ativo,usua_admin,usua_senha)
					VALUES (:usua_nome, :usua_email,1,:usua_admin,:usua_senha )";
					$sth = $this->db->prepare($sql);
					$senha = base64_encode($dados['senha']);			
					$sth->bindParam("usua_nome",$dados['nome']);
					$sth->bindParam("usua_email",$dados['email']);
					$sth->bindParam("usua_admin",$dados['admin']);
					$sth->bindParam("usua_senha",$senha);
					$sth->execute();
					$resultado = ['sucesso' => true,'mensagem'=> ''];
					return json_encode($resultado);
				}

			}else{
				$resultado = ['sucesso' => false,"mensagem"=>"Nome, Senha e E-mail são obrigatórios"];
				return json_encode($resultado);
			}
		
		}

		public function alterarUsuarios($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$dados = $request->getParsedBody();

			$id = (int)$args['id'];

			if(!empty($id) && !empty($dados['nome']) && !empty($dados['email']) && !empty($dados['senha'])){

				$query = "SELECT usua_email FROM `usuario` 
				where `usua_email` = '".$dados['email']."' AND usua_codigo != ".$id;
				$usuario_sql = $this->db->prepare($query);
				$usuario_sql->execute();
				$usuario = $usuario_sql->fetch();

				if(!empty($usuario)){
					$resultado = ['sucesso' => false,"mensagem"=>"E-Mail já existe, Favor informar outro"];
					return json_encode($resultado);
				}else{
					$sql = "UPDATE `usuario` SET usua_nome=:usua_nome,usua_email=:usua_email,usua_admin=:usua_admin,usua_senha=:usua_senha WHERE `usua_codigo`=".$id;
					$sth = $this->db->prepare($sql);
					$senha = base64_encode($dados['senha']);			
					$sth->bindParam("usua_nome",$dados['nome']);
					$sth->bindParam("usua_email",$dados['email']);
					$sth->bindParam("usua_admin",$dados['admin']);
					$sth->bindParam("usua_senha",$senha);
					$sth->execute();
					$resultado = ['sucesso' => true,'mensagem'=> ''];
					return json_encode($resultado);
				}

			}else{
				$resultado = ['sucesso' => false,"mensagem"=>"Nome, Senha e E-mail são obrigatórios"];
				return json_encode($resultado);
			}
		
		}

		public function inativarAtivarUsuarios($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$dados = $request->getParsedBody();

			$id = (int)$args['id'];
			$ativo = (int)$args['ativo'];

			if(!empty($id)){
				$sql = "UPDATE `usuario` SET `usua_ativo`=:usua_ativo WHERE `usua_codigo`=".$id;
				$sth = $this->db->prepare($sql);			
				$sth->bindParam("usua_ativo",$ativo, PDO::PARAM_INT);
				$sth->execute();
				$resultado = ['sucesso' => true,'mensagem'=> ''];
				return json_encode($resultado);
			

			}else{
				$resultado = ['sucesso' => false,"mensagem"=>"id e status obrigatório"];
				return json_encode($resultado);
			}
		
		}


	}