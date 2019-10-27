import { Component, OnInit } from '@angular/core';
import {TermosService} from '../termos.service';

@Component({
  selector: 'app-termos',
  templateUrl: './termos.component.html',
  styleUrls: ['./termos.component.scss']
})
export class TermosComponent implements OnInit {

  termos:String[];

  constructor(private termosService:TermosService) {
		this.termos = [];
	}

  ngOnInit() {
    this.termosService.getTermos()
      .subscribe(
        termos => this.termos = termos,
        error => console.log('erro')
    );
  }

  excluir(id){
    this.termosService.deleteTermos(id)
      .subscribe(
        data => {
          if(data.sucesso == true){
            this.termosService.getTermos()
            .subscribe(
              termos => this.termos = termos,
              error => console.log('erro')
          );
        }          
        },
        error => console.log('erro')
    );
  }

  buscarTermos(){
    let me = this;
    this.termosService.buscarTermos()
      .subscribe(
        data => {
          me.termosService.getTermos()
          .subscribe(
            termos => this.termos = termos,
            error => console.log('erro')
          );
        },
        error => console.log('erro')
    );
  }

}
