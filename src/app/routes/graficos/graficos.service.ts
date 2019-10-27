import { Injectable } from '@angular/core';
import { Http ,Headers,Response} from '@angular/http';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';


@Injectable()
export class GraficosService {

  url:any = environment.apiUrl;
    constructor(private httpClient:Http) {
  }

  getRamoAtividade(ramo): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`grafico_ramo_atividade/`+ramo)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }

   getGraficoClienteLead(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`grafico_cliente_lead`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }

   getGraficoPorcentagem(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`grafico_porcentagem`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }

   getGraficoEstado(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`grafico_regiao_estado`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }
   
   getGraficoCidade(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`grafico_regiao_cidade`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }

   getGraficoBairro(): Observable<any> {
    let me = this;
    return this.httpClient.get(me.url+`grafico_regiao_bairro`)
        .map(res=> res.json())
        .catch(err=> Observable.throw(err.message));
   }

}
