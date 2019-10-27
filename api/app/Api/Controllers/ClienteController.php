<?php
	namespace Api\Controllers;
	use Api\Controllers\Controller;
	class ClienteController extends Controller{
		public function listaClientes($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$clientes_sql = $this->db->prepare("SELECT * FROM `cliente`");
			$clientes_sql->execute();
			$clientes = $clientes_sql->fetchAll();
			return $response->withJson($clientes, 200);
		}
		public function listaCliente($request,$response,$args){
			$retorno = array();
			$id = (int)$args['id'];
			if($id > 0){
				$clientes_sql = $this->db->prepare("SELECT * FROM `cliente` where `clie_codigo` = ".$id);
				$clientes_sql->execute();
				$clientes = $clientes_sql->fetchAll();
				$retorno = json_encode($clientes);
			}
			return $retorno;
		}

		public function listaClientesPaginate($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = array();
			
			$qtd = (int)$args['qtd'];
			$page = ((int)$args['page'] - 1) * $qtd;
			$leads_sql = $this->db->prepare("SELECT * FROM `cliente` limit $page,$qtd");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;
		}
		

		public function countCliente($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = array();
			$leads_sql = $this->db->prepare("SELECT count(*) as total FROM `cliente`");
			$leads_sql->execute();
			$leads = $leads_sql->fetch();
			$retorno = json_encode($leads);
			return $retorno;
		}

		public function incluirClientes($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$dados = $request->getParsedBody();
			if(!empty($dados['razao-social']) && !empty($dados['cnpj'])){
				$sql = "INSERT INTO cliente (clie_razao_social,clie_cnpj,clie_ativo)
					VALUES (:clie_razao_social, :clie_cnpj,0 )";
				$sth = $this->db->prepare($sql);
				
				$sth->bindParam("clie_razao_social",$dados['razao-social']);
				$sth->bindParam("clie_cnpj", str_replace(['/','.','-'],'',$dados['cnpj']));
				$sth->execute();
				$resultado = ['sucesso' => true,'mensagem'=> ''];
				return json_encode($resultado);
			}else{
				$resultado = ['sucesso' => false,"mensagem"=>"Razão social e CNPJ obrigatórios"];
				return json_encode($resultado);
			}
		
		}
		
		public function upload($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');
			$dados = $request->getParsedBody();
			$csv = base64_decode($dados['file']);
			$arquivos = explode(PHP_EOL,$csv);
			$total = 0;
			$n_total = 0;
			$sucesso = false;
			$erros=[];
			foreach($arquivos as $key => $arquivo){
				try{
					$dados = explode(";",$arquivo);
					
					if(!empty($dados['0']) && !empty($dados['1'])){
						$cnpj = $dados['1'];
						$clientes_sql = $this->db->prepare("SELECT * FROM `cliente` where `clie_cnpj` = {$cnpj}");
						
						$clientes_sql->execute();
						$clientes = $clientes_sql->fetch();
						
						if(!$clientes){
							$sql = "INSERT INTO cliente (clie_razao_social,clie_cnpj,clie_ativo)
								VALUES (:clie_razao_social, :clie_cnpj,0 )";
							$sth = $this->db->prepare($sql);
							
							$sth->bindParam("clie_razao_social",$dados['0']);
							$sth->bindParam("clie_cnpj", str_replace(['/','.','-'],'',$dados['1']));
							$sth->execute();
							$sucesso = true;
							$total++;
						}else{
							$msg = 'Erro na linha '.$key.' do arquivo';
							$erros[] = 'Cliente já cadastrado';
							$n_total++;
						}
					}else{
						$msg = 'Erro na linha '.$key.' do arquivo';
						$erros[] = $msg;
						$n_total++;
					}
				}catch(PDOException $e){
					$msg = 'Erro na linha '.$key.' do arquivo';
					$erros[] = 'Erro';
					$n_total++;
				}
			}
			$retorno = ['sucesso' => $sucesso,'qtd' => $total,'nao_incluidos'=>$n_total,'erros'=>$erros];
			return json_encode($retorno);
		}

		function capturarCnae(){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: *');			
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');
			set_time_limit(0);
			$retorno = ['sucesso' => 'ok','erros'=>''];
			$clientes_sql = $this->db->prepare("SELECT * FROM `cliente`
			LEFT JOIN `cliente_cnae` ON  (clie_codigo = ccna_clie_codigo)
			WHERE clie_ativo = 0 and ccna_clie_codigo is null limit 10");
			$clientes_sql->execute();
			$clientes = $clientes_sql->fetchAll();
			$retorno = ['sucesso' => false];
			foreach($clientes as $cliente){
				ob_start();				
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,"https://www.receitaws.com.br/v1/cnpj/".$cliente['clie_cnpj']);
				curl_exec($ch);
				$data = json_decode(ob_get_contents(),true);
				curl_close($ch);
				ob_end_clean();
				ob_start();
				$cnaes[] = substr($data['atividade_principal'][0]['code'],0,7).'/'.substr($data['atividade_principal'][0]['code'],-2);
				foreach($data['atividades_secundarias'] as $atividade){
					$cnaes[] = substr($atividade['code'],0,7).'/'.substr($atividade['code'],-2);
				}
				
				foreach($cnaes as $codigo_cnae){
					$cnae_sql = $this->db->prepare("SELECT * FROM `cnae` WHERE cnae_codigo_cnae = \"$codigo_cnae\"");
					
					$cnae_sql->execute();
					$cnae = $cnae_sql->fetch();
					var_dump($cnae);
					if(!empty($cnae['cnae_codigo'])){
						$sql = "INSERT INTO cliente_cnae (ccna_clie_codigo,ccna_cnae_codigo)
						VALUES (:ccna_clie_codigo, :ccna_cnae_codigo)";
						$sth = $this->db->prepare($sql);				
						$sth->bindParam("ccna_clie_codigo", $cliente['clie_codigo']);
						$sth->bindParam("ccna_cnae_codigo", $cnae['cnae_codigo']);
						$sth->execute();

						$sql_cliente = "UPDATE `cliente` SET `clie_ativo`=1 WHERE `clie_codigo`=".$cliente['clie_codigo'];
						$sth_cliente = $this->db->prepare($sql_cliente);		
						$sth_cliente->execute();
						$retorno = ['sucesso' => true];
					}
				}
				sleep(20);
			}
			return json_encode($retorno);
		}

		public function gravaTermos($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');
			set_time_limit(0);
			$retorno = array();
			$termos_sql = $this->db->prepare("SELECT cnae_descricao FROM `cliente` inner join `cliente_cnae` ON (ccna_clie_codigo = clie_codigo)
			inner join `cnae` ON (cnae_codigo = ccna_cnae_codigo) ");
			
			$termos_sql->execute();		
			
			$termos = $termos_sql->fetchAll();
			
			foreach($termos as $termo){
				foreach(explode(',',$termo['cnae_descricao']) as $t){
					foreach(explode(' e ',$t) as $nt){
						if(strlen($nt) > 3){
							$valor[trim($nt)] = trim($nt);
						}						
					}
					
				}
				
			}
			sort($valor);
			foreach($valor as $v){
				$termos_sql = $this->db->prepare("SELECT * FROM `termo` WHERE term_descricao = '".$v."'");			
				$termos_sql->execute();					
				$termos = $termos_sql->fetch();
				if(empty($termos)){
					$sql = "INSERT INTO termo (term_descricao) VALUES (:term_descricao )";
					$sth = $this->db->prepare($sql);				
					$sth->bindParam("term_descricao",$v);
					$sth->execute();	
				}

				
			}
			

			$retorno = json_encode($valor);			
			return $retorno;
		}

	}