import { Injectable } from '@angular/core';
import { Http ,Headers,Response} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class ClientesService {

  url:any = environment.apiUrl;
  constructor(private httpClient:Http) {
  }


  getClientes(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`cliente`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }
   
   getClientesCount(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`cliente_count`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
  }

   getClientesPaginate(page,qtd): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`clientes/`+page+'/'+qtd)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
 	}

    
   setCliente(cliente): Observable<any> {
        let me = this;
        let body = new FormData();

        body.append('razao-social', cliente.razaoSocial);
        body.append('cnpj', cliente.cnpj);

        return this.httpClient.post(me.url+`cliente`,body)
            .map(res=> res.json())
            .catch(err=> Observable.throw(err.message));
    }
    
    uploadCSV(file): Observable<any> {
        let me = this;    
        let body = new FormData();
        body.append('file', file);
        return this.httpClient.post(me.url+`cliente-upload`,body)
            .map(res=> res.json())
            .catch(err=> Observable.throw(err.message));
    }
     
    processarCnae(): Observable<any> {
        let me = this;    
        return this.httpClient.get(me.url+`clientes-cnae`)
            .map(res=> res.json())
            .catch(err=> Observable.throw(err.message));
    } 
 

}
