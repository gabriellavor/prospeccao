import { Injectable } from '@angular/core';
import { Http ,Headers,Response} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';


@Injectable()
export class ConfiguracaoService {

  url:any = environment.apiUrl;
    constructor(private httpClient:Http) {
  }

  busca(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`busca-configuracao`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

  porcentagem(porcentagem): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`configuracao/`+porcentagem)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

}
