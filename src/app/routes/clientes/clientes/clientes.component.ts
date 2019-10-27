import { Component, OnInit } from '@angular/core';
import {ClientesService} from '../clientes.service';

@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.scss']
})
export class ClientesComponent implements OnInit {

	clientes:String[];
	title:String = 'Clientes';
  carregado:boolean = false;
  carregado_cnae:boolean = false;
	total:number = 0;
	constructor(private clientesService:ClientesService) {
		this.clientes = [];
	}

	ngOnInit() {
    let me = this;
		me.carregado = false;
    this.clientesService.getClientesCount()
      .subscribe(
        total => this.total = total.total,
        error => console.log('erro')
		);
		
    this.clientesService.getClientesPaginate(1,10)
      .subscribe(
        clientes => {
          me.carregado = true;
          this.clientes = clientes
        }
      );
	}

	paginar(page,qtd){
    let me = this;
    me.carregado = false;
    this.clientesService.getClientesCount()
      .subscribe(
        total => this.total = total.total,
        error => console.log('erro')
		);
		
    this.clientesService.getClientesPaginate(page,qtd)
      .subscribe(
        clientes => {
          me.carregado = true;
          this.clientes = clientes
        }
      );
  }

  processarCnae(){
    let me =this;
    me.carregado_cnae = true;
    this.clientesService.processarCnae()
      .subscribe(
        data => {console.log(data),me.carregado_cnae = false;},
        error => console.log('erro')
		);
  }

}
