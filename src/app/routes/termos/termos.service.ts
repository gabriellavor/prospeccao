import { Injectable } from '@angular/core';
import { Http ,Headers,Response} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';


@Injectable()
export class TermosService {

  url:any = environment.apiUrl;
    constructor(private httpClient:Http) {
  }

  getTermos(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`termo`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

  deleteTermos(id): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`termo-excluir/`+id)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }
  

  setTermo(termo): Observable<any> {
    let me = this;
    let body = new FormData();

    body.append('descricao', termo.descricao);

    return this.httpClient.post(me.url+`termo`,body)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

  buscarTermos(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`clientes/termos`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }
  

}
