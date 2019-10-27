<?php
	namespace Api\Controllers;
	use Api\Controllers\Controller;
	class LeadController extends Controller{
		public function listaLeads($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			$leads_sql = $this->db->prepare("SELECT * FROM `lead`");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			return $response->withJson($leads, 200);
		}
		public function listaLead($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = array();
			$id = (int)$args['id'];
			if($id > 0){
			
				$query = "SELECT * FROM `lead` 
				inner join lead_cnae ON (lcna_lead_codigo = lead_codigo)
				inner join cnae ON (lcna_cnae_codigo = cnae_codigo)
				inner join contato ON (cont_lead_codigo = lead_codigo)
				inner join tipo_contato ON (tcon_codigo = cont_tcon_codigo)
				left join facebook ON (face_lead_codigo = lead_codigo)
				where `lead_codigo` = ".$id;
				$leads_sql = $this->db->prepare($query);
				$leads_sql->execute();
				$leads = $leads_sql->fetchAll();
				$lead = [];
				foreach($leads as $key => $l){
					$lead['lead_codigo'] = $l['lead_codigo'];
					$lead['lead_razao_social'] = $l['lead_razao_social'];
					$lead['lead_rua'] = $l['lead_rua'];
					$lead['lead_bairro'] = $l['lead_bairro'];
					$lead['lead_cidade'] = $l['lead_cidade'];
					$lead['lead_uf'] = $l['lead_uf'];
					$lead['lead_cep'] = $l['lead_cep'];
					$lead['lead_cnpj'] = $l['lead_cnpj'];
					$lead['facebook']['name'] = $l['face_nome'];
					$lead['facebook']['email'] = $l['face_email'];
					$lead['facebook']['website'] = $l['face_site'];
					$lead['facebook']['phone'] = $l['face_telefone'];
					$lead['lead_porcentagem'] = $l['lead_porcentagem'];
					$lead['cnae'][$l['cnae_codigo_cnae']]['cnae_codigo_cnae'] = $l['cnae_codigo_cnae'];
					$lead['cnae'][$l['cnae_codigo_cnae']]['cnae_descricao'] = $l['cnae_descricao'];
					$lead['contato'][$l['cont_descricao']]['cont_descricao'] = $l['cont_descricao'];
					$lead['contato'][$l['cont_descricao']]['tcon_descricao'] = $l['tcon_descricao'];
				}
				
				if(!empty($lead)){
					sort($lead['cnae']);
					sort($lead['contato']);	
				}
				if(empty($lead['facebook'])){
					$facebook = $this->facebook($lead['lead_razao_social'],$lead['lead_codigo']);
					if($facebook){
						$lead['facebook'] = $facebook;
					}	
				}
								
				$retorno = json_encode($lead);
			}
			return $retorno;
		}
		public function listaLeadsPaginate($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			
			
			$retorno = array();
			
			$qtd = (int)$args['qtd'];
			$estado = $args['estado'];
			$bairro = $args['bairro'];
			$cidade = $args['cidade'];
			$condicao = "WHERE 1 = 1";
			if(!empty($estado) && $estado != 'Estado'){
				$condicao = "WHERE lead_uf = '$estado'";
				if(!empty($cidade && $cidade != 'Cidade')){
					$condicao .= " AND lead_cidade = '$cidade'";
					if(!empty($bairro) && $bairro != 'Bairro'){
						$condicao .= " AND lead_bairro = '$bairro'";
					}
				}
			}
			$page = ((int)$args['page'] - 1) * $qtd;
			$leads_sql = $this->db->prepare("SELECT * FROM `lead` $condicao ORDER BY lead_porcentagem DESC limit $page,$qtd");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;
		}
		

		public function countLead($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			

			$estado = $args['estado'];
			$bairro = $args['bairro'];
			$cidade = $args['cidade'];

			$condicao = "WHERE 1 = 1";
			if(!empty($estado) && $estado != 'Estado'){
				$condicao = "WHERE lead_uf = '$estado'";
				if(!empty($cidade && $cidade != 'Cidade')){
					$condicao .= " AND lead_cidade = '$cidade'";
					if(!empty($bairro) && $bairro != 'Bairro'){
						$condicao .= " AND lead_bairro = '$bairro'";
					}
				}
			}
			
			$retorno = array();
			$leads_sql = $this->db->prepare("SELECT count(*) as total FROM `lead` $condicao");
			$leads_sql->execute();
			$leads = $leads_sql->fetch();
			$retorno = json_encode($leads);
			return $retorno;
		}

		public function facebook($razao_social,$lead_codigo){
			
				if(!empty($razao_social)){
				try{	
					$fb = new \Facebook\Facebook([
						'app_id' => '',
						'app_secret' => '',
						'default_graph_version' => 'v3.1'
						]);
						
						$response = $fb->get(
						'/search?type=place&q='.$razao_social.'&fields=name',
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
					$empresa = [];
					
					foreach($resultado as $key => $result){
						$retorno_empresa = $this->facebook_empresa($result['id']);
						if(!empty($retorno_empresa['website'])){
							$empresa = $retorno_empresa;
							break;
						}
						if($key == 0){
							$primeiro = $retorno_empresa;
						}
						if(count($resultado) == $key && empty($retorno_empresa['website'])){
							$empresa = $primeiro;
						}
					}
					$this->incluir($empresa,$lead_codigo);
					return $empresa;		
				}else{
					return [];
				}
			
		}

		function facebook_empresa($codigo,$lead_codigo){
			try{
				$fb = new \Facebook\Facebook([
					'app_id' => '',
					'app_secret' => '',
					'default_graph_version' => 'v3.1'
					]);
					
					$response = $fb->get(
					'/'.$codigo.'?fields=website,name,about,description,phone',
					'|yv-FCGayR9IrQ8G2_vKI2sCCW04'
					);
				} catch(FacebookExceptionsFacebookResponseException $e) {
					echo 'Graph returned an error: ' . $e->getMessage();
					exit;
				} catch(FacebookExceptionsFacebookSDKException $e) {
					echo 'Facebook SDK returned an error: ' . $e->getMessage();
					exit;
				}
				
				$resultado = $response->getGraphObject()->asArray();
				
				return $resultado;
		}

		function incluir($empresa,$lead_codigo){
			$sql = "INSERT INTO facebook (face_lead_codigo,face_site,face_nome,face_telefone,face_email)
				VALUES (:face_lead_codigo,:face_site,:face_nome,:face_telefone,:face_email)";
			$sth = $this->db->prepare($sql);
			$sth->bindParam("face_lead_codigo",$lead_codigo);
			$sth->bindParam("face_site", $empresa['website']);
			$sth->bindParam("face_nome", $empresa['name']);
			$sth->bindParam("face_telefone", $empresa['phone']);
			$sth->bindParam("face_email", $empresa['email']);
			$sth->execute();
		}

		public function retorna_estados($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			

			$retorno = array();
			$leads_sql = $this->db->prepare("SELECT DISTINCT lead_uf AS name FROM `lead` ORDER BY lead_uf");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;
		}

		public function retorna_cidades($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			

			$estado = $args['estado'];
			$condicao = "WHERE lead_uf = '$estado'";
			$retorno = array();
			$leads_sql = $this->db->prepare("SELECT DISTINCT lead_cidade AS name FROM `lead` $condicao ORDER BY lead_cidade");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;
		}

		public function retorna_bairros($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');			

			$estado = $args['estado'];
			$cidade = $args['cidade'];
			$condicao = "WHERE lead_uf = '$estado' AND lead_cidade = '$cidade'";

			$retorno = array();
			$leads_sql = $this->db->prepare("SELECT DISTINCT lead_bairro AS name FROM `lead` $condicao ORDER BY lead_bairro");
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;
		}

		public function grafico_ramo_atividade($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$ramo = $args['ramo'];
			if($ramo == 'Lead'){
				$condicao = ' order by lead DESC, cliente DESC,descricao ';
			}else{
				$condicao = ' order by cliente DESC,lead DESC,descricao ';
			}

			$sql = "SELECT descricao,sum(qtd_cliente) as cliente,sum(qtd_lead) as lead
			FROM (
			SELECT cnae_descricao as descricao,count(*) as qtd_cliente,0  as qtd_lead FROM `cliente` 
			inner join cliente_cnae ON (cliente.clie_codigo = cliente_cnae.ccna_clie_codigo)
			inner join cnae ON(cliente_cnae.ccna_cnae_codigo = cnae.cnae_codigo)
			group by descricao
			union all
			SELECT cnae_descricao as descricao,0  as qtd_cliente,count(*) as qtd_lead FROM `lead` 
			inner join lead_cnae ON (lead.lead_codigo = lead_cnae.lcna_lead_codigo)
			inner join cnae ON(lead_cnae.lcna_cnae_codigo = cnae.cnae_codigo)
			group by descricao
			) as ramo
			group by descricao
			$condicao
			LIMIT 10";
			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}

		public function grafico_cliente_lead($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$sql = "SELECT SUM(cliente) as cliente,SUM(lead) AS lead
			FROM(
				SELECT COUNT(*) as cliente ,0 as lead FROM cliente
				UNION ALL
				SELECT 0 as cliente,COUNT(*) as lead FROM lead
			) AS total";

			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}

		public function grafico_porcentagem($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$sql = "SELECT TRUNCATE(lead_porcentagem,0) as porcentagem,count(*) as qtd FROM lead
			group by TRUNCATE(lead_porcentagem,0) order by lead_porcentagem DESC";

			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}

		public function grafico_regiao_estado($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$sql = "SELECT lead_uf,count(*) as qtd FROM `lead` group by lead_uf order by count(*) desc LIMIT 10";

			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}

		public function grafico_regiao_cidade($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$sql = "SELECT lead_cidade,count(*) as qtd FROM `lead` group by lead_cidade order by count(*) desc LIMIT 10";

			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}

		public function grafico_regiao_bairro($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$sql = "SELECT lead_bairro,count(*) as qtd FROM `lead` group by lead_bairro order by count(*) desc LIMIT 10";

			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}

		

		public function buscaConfiguracao($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$sql = "SELECT * FROM configuracao";

			$leads_sql = $this->db->prepare($sql);
			$leads_sql->execute();
			$leads = $leads_sql->fetchAll();
			$retorno = json_encode($leads);
			return $retorno;

		}
		
		public function configuracao($request,$response,$args){
			header('Access-Control-Allow-Origin: *');
			header('Access-Control-Allow-Methods: GET');
			header('Access-Control-Allow-Headers: token, Content-Type');
			header('Access-Control-Allow-Credential: true');
			header('Content-Type: text/json');
			header('Cache-Control: no-cache');

			$porcentagem = $args['porcentagem'];

			if($porcentagem >= 0 && $porcentagem <= 100){
				$sql_cliente = "UPDATE `configuracao` SET `conf_porcentagem`=$porcentagem WHERE `conf_codigo`= 1";
				$sth_cliente = $this->db->prepare($sql_cliente);		
				$sth_cliente->execute();

				$retorno = json_encode(['sucesso' => true]);
			}else{
				$retorno = json_encode(['sucesso' => false]);
			}

			return $retorno;

		}
		
		

	}