import { Injectable } from '@angular/core';
import { Http ,Headers,Response} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class LeadsService {

  url:any = environment.apiUrl;
  constructor(private httpClient:Http) {
  }

  getLead(codigo:Number): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`lead/`+codigo)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
 	}

  getLeadsCount(uf,cidade,bairro): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`lead_count/`+uf+'/'+cidade+'/'+bairro)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

  getLeads(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`lead`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }
   
  getLeadsPaginate(page,qtd,uf,cidade,bairro): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`leads/`+page+'/'+qtd+'/'+uf+'/'+cidade+'/'+bairro)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
 	}

  getEstados(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`retorna_estados`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }
   
   getCidades(uf): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`retorna_cidades/`+uf)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }
   
   getBairros(uf,bairro): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`retorna_bairros/`+uf+'/'+bairro)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
 	}
}
