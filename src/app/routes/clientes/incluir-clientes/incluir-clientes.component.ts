import { Component, OnInit } from '@angular/core';
import {ClientesService} from '../clientes.service';

@Component({
  selector: 'app-incluir-clientes',
  templateUrl: './incluir-clientes.component.html',
  styleUrls: ['./incluir-clientes.component.scss']
})
export class IncluirClientesComponent implements OnInit {

  constructor(private clientesService:ClientesService) {	}

  retorno:any = {
    mensagem:'',
    sucesso:true,
    envio:false
  };

  ngOnInit() {
  }

  onSubmit(formulario){
    
    this.clientesService.setCliente(formulario.value)
      .subscribe(
        data => {
          if(data.sucesso == false){
            this.retorno.sucesso = false;
            this.retorno.mensagem = data.mensagem;
          }else{
            this.retorno.sucesso = true;
            this.retorno.mensagem = 'incluido com sucesso';
          }
          this.retorno.envio = true;
        }
      );
	  }
}