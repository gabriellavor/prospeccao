import { Component, OnInit } from '@angular/core';
import { ActivatedRoute} from '@angular/router';
import {UsuariosService} from '../usuarios.service';


@Component({
  selector: 'app-visualizar-usuarios',
  templateUrl: './visualizar-usuarios.component.html',
  styleUrls: ['./visualizar-usuarios.component.scss']
})
export class VisualizarUsuariosComponent implements OnInit {

  id:any;
  usuario:any;

  constructor(
    private route: ActivatedRoute,private usuarioService:UsuariosService
  ) {
    this.usuario = []; 
  }

  ngOnInit() {
    this.id = this.route.snapshot.paramMap.get('id');
		this.usuarioService.getUsuario(this.id)
      .subscribe(
        users => this.usuario = users,
        error => console.log('erro')
      );
  }
  

}
