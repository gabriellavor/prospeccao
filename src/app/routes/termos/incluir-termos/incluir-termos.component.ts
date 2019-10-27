import { Component, OnInit } from '@angular/core';
import {TermosService} from '../termos.service';
import { Validators } from '@angular/forms';
import { FormBuilder, ValidatorFn } from '@angular/forms';
import { FormGroup } from '@angular/forms/src/model';


@Component({
  selector: 'app-incluir-termos',
  templateUrl: './incluir-termos.component.html',
  styleUrls: ['./incluir-termos.component.scss']
})
export class IncluirTermosComponent implements OnInit {

  retorno:any = {
    mensagem:'',
    sucesso:true,
    envio:false
  };

  formulario:FormGroup;

  constructor(private termosService:TermosService,private fb: FormBuilder) {	}

  ngOnInit() {
  }

  onSubmit(formulario){
    
    this.termosService.setTermo(formulario.value)
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
