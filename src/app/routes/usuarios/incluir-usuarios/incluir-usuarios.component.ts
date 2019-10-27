import { Validators } from '@angular/forms';
import { FormBuilder, ValidatorFn } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import {UsuariosService} from '../usuarios.service';
import { FormGroup } from '@angular/forms/src/model';

@Component({
  selector: 'app-incluir-usuarios',
  templateUrl: './incluir-usuarios.component.html',
  styleUrls: ['./incluir-usuarios.component.scss']
})
export class IncluirUsuariosComponent implements OnInit {

  constructor(private usuariosService:UsuariosService,private fb: FormBuilder) {	}

  retorno:any = {
    mensagem:'',
    sucesso:true,
    envio:false
  };

  formulario:FormGroup;

  ngOnInit() {
    this.formulario = this.fb.group({
      confirmarSenha: ['', Validators.required]
    });
  }



  onSubmit(formulario){
    
    this.usuariosService.setUsuario(formulario.value)
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
