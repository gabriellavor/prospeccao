import { Component, OnInit } from '@angular/core';
import {ConfiguracaoService} from '../configuracao.service';
import { FormGroup } from '@angular/forms/src/model';

@Component({
  selector: 'app-configuracao',
  templateUrl: './configuracao.component.html',
  styleUrls: ['./configuracao.component.scss']
})
export class ConfiguracaoComponent implements OnInit {

  descricao = 0;
  formulario:FormGroup;

  retorno:any = {
    mensagem:'',
    sucesso:true,
    envio:false
  };

  constructor(private configuracaoService:ConfiguracaoService) {}

  ngOnInit() {
    this.buscaConfiguracao();
  }

  buscaConfiguracao(){
    let me = this;
    this.configuracaoService.busca()
      .subscribe(
        data => {
          me.descricao = data[0].conf_porcentagem;
          
        },
        error => console.log('erro')
    );
  }
  
  onSubmit(formulario){
    let me = this;
    this.configuracaoService.porcentagem(me.descricao)
      .subscribe(
        data => {
          if(data.sucesso == true){
            me.retorno.mensagem = 'Incluido com sucesso!';
            me.retorno.sucesso = true;
            me.retorno.envio = true;
          }else{
            me.retorno.mensagem = 'Informar a porcentagem de 0 a 100';
            me.retorno.sucesso = false;
            me.retorno.envio = true;
          }
          
        },
        error => console.log('erro')
    );
  }

}
