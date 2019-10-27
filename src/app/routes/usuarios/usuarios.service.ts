import { Injectable } from '@angular/core';
import { Http ,Headers,Response} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { HttpParams } from '@angular/common/http/src/params';
import { HttpHeaders } from '@angular/common/http/src/headers';

@Injectable()
export class UsuariosService {

  private headers = new Headers({'Content-Type' : 'application/json'});

  url:any = environment.apiUrl;
    constructor(private httpClient:Http) {
  }
  
  getUsuario(codigo:Number): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`usuario/`+codigo)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
 	}

  getUsuariosCount(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`usuario_count`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

  getUsuariosPaginate(page,qtd): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`usuarios/`+page+'/'+qtd)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
 	}
  
  setUsuario(usuario): Observable<any> {
    let me = this;
    let body = new FormData();
    body.append('nome', usuario.nome);
    body.append('email', usuario.email);
    body.append('senha', usuario.senha);
    body.append('admin', usuario.admin);

    return this.httpClient.post(me.url+`usuario`,body)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

  alterarUsuario(codigo,usuario): Observable<any> {
    let me = this;
    let body = new FormData();
    body.append('nome', usuario.nome);
    body.append('email', usuario.email);
    body.append('senha', usuario.senha);
    body.append('admin', usuario.admin);

    return this.httpClient.post(me.url+`usuario/`+codigo,body)
    .map(res=> res.json()).catch(err=> Observable.throw(err.message));
  }

  ativarInativarUsuario(codigo,ativo): Observable<any> {
    let me = this;;
    let status = ativo ? 1 : 0;
    return this.httpClient.get(me.url+`usuario-inativar/`+codigo+'/'+status)
    .map(res=> res.json()).catch(err=> Observable.throw(err.message));
  }

}
