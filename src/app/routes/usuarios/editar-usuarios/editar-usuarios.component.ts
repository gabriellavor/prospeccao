import { FormBuilder, Validators, FormControl } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { UsuariosService } from '../usuarios.service';
import { FormGroup } from '@angular/forms/src/model';
import { ActivatedRoute} from '@angular/router';

@Component({
  selector: 'app-editar-usuarios',
  templateUrl: './editar-usuarios.component.html',
  styleUrls: ['./editar-usuarios.component.scss']
})
export class EditarUsuariosComponent implements OnInit {

  constructor(private usuarioService:UsuariosService,private fb: FormBuilder,private route: ActivatedRoute) { }

  retorno:any = {
    mensagem:'',
    sucesso:true,
    envio:false
  };
  id:any;

  formulario:FormGroup;
  usuario:any = {id:null,nome:null,email:null,admin:null,senha:null,confirmarSenha:null};
  ngOnInit() {
    this.formulario = this.fb.group({
      confirmarSenha: ['', Validators.required]
    });
    this.id = this.route.snapshot.paramMap.get('id');
    this.usuarioService.getUsuario(this.id)
      .subscribe(
        data => {
          if(data.usua_nome != undefined){
            this.usuario.id = data.usua_codigo;
            this.usuario.nome = data.usua_nome;
            this.usuario.email = data.usua_email;
            this.usuario.senha = atob(data.usua_senha);
            this.usuario.confirmarSenha = this.usuario.senha;    
            this.usuario.admin = data.usua_admin;
          }
          
        }
      );
    
  }
  
  onSubmit(formulario){
    
    this.usuarioService.alterarUsuario(this.usuario.id,formulario.value)
      .subscribe(
        data => {
          if(data.sucesso == false){
            this.retorno.sucesso = false;
            this.retorno.mensagem = data.mensagem;
          }else{
            this.retorno.sucesso = true;
            this.retorno.mensagem = 'alterado com sucesso';
          }
          this.retorno.envio = true;
        }
      );
	  }


}
