import { Component, OnInit } from '@angular/core';
import {UsuariosService} from '../usuarios.service';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent implements OnInit {

  usuarios:String[];
	title:String = 'Usuarios';
	carregado:boolean = false;
  total:number = 0;
  pagina_atual:number = 1;
  total_pagina:number = 10;
	constructor(private usuariosService:UsuariosService) {
		this.usuarios = [];
	}

	ngOnInit() {
    let me = this;
    me.carregado = false;
    me.pagina_atual = 1;
    this.usuariosService.getUsuariosCount()
      .subscribe(
        total => this.total = total.total,
        error => console.log('erro')
		);
		
    this.usuariosService.getUsuariosPaginate(1,me.total_pagina)
      .subscribe(
        data => {
          me.carregado = true;
          this.usuarios = data
        }
      );
	}

	paginar(page,qtd){
    let me = this;
    me.carregado = false;
    me.pagina_atual = page;
    this.usuariosService.getUsuariosCount()
      .subscribe(
        total => this.total = total.total,
        error => console.log('erro')
		);
		
    this.usuariosService.getUsuariosPaginate(page,qtd)
      .subscribe(
        data => {
          me.carregado = true;
          this.usuarios = data
        }
      );
  }

  inativarAtivar(codigo,ativo){
    let me = this;
    let status = ativo == 1 ? 0 : 1;
    this.usuariosService.ativarInativarUsuario(codigo,status)
      .subscribe(
        data => {
          console.log(data);
          me.paginar(me.pagina_atual,me.total_pagina)
        }
    );
  }

}
