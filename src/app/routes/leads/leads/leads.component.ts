import { Component, OnInit,ChangeDetectionStrategy,ChangeDetectorRef} from '@angular/core';
import {LeadsService} from '../leads.service';
import { SelectComponent } from 'ng2-select/ng2-select';


@Component({
  selector: 'app-leads',
  templateUrl: './leads.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrls: ['./leads.component.scss']
})
export class LeadsComponent implements OnInit {

  leads:String[];
  total:number = 0;
  title:String = 'Leads';
  carregado:boolean = false;
  carregando_estado:boolean = false;
  carregando_cidade:boolean = false;
  carregando_bairro:boolean = false;
  uf:any = 'Estado';
  cidade:any = 'Cidade';
  bairro:any = 'Bairro';
  estados:any = ['Estado'];
  cidades:any = ['Cidade'];
  bairros:any = ['Bairro'];


	constructor(private leadsService:LeadsService, public ref:ChangeDetectorRef) {
		this.leads = [];
	}

	ngOnInit() {
    let me = this;
    me.carregado = false;
    
    this.buscaEstados();
    
    this.leadsService.getLeadsCount(me.uf,me.cidade,me.bairro)
      .subscribe(
        total => this.total = total.total,
        error => console.log('erro')
    );
    this.leadsService.getLeadsPaginate(1,10,me.uf,me.cidade,me.bairro)
      .subscribe(
        leads => {
          me.carregado = true;
          this.leads = leads;
          me.ref.markForCheck();
        },
        error => console.log('erro'));
  }

  paginar(page,qtd){
    let me = this;
    me.carregado = false;
    this.leadsService.getLeadsCount(me.uf,me.cidade,me.bairro)
      .subscribe(
        total => this.total = total.total,
        error => console.log('erro')
    );
    this.leadsService.getLeadsPaginate(page,qtd,me.uf,me.cidade,me.bairro)
      .subscribe(
        leads => {
          me.carregado = true;
          this.leads = leads
          me.ref.markForCheck();
        }
      );
  }

  buscaEstados(){
    let me = this;
    me.estados = ['Estado'];
    this.leadsService.getEstados().subscribe(
      estados => {
        estados.forEach(role => {
          this.estados = [...this.estados, role.name];
        });
        this.paginar(1,10);
      }
    );          
    
  }

  buscaCidades(){ 
    this.cidades = ['Cidade'];
    this.cidade = 'Cidade';
    this.leadsService.getCidades(this.uf).subscribe(
      cidades => {
        cidades.forEach(role => {
          this.cidades = [...this.cidades, role.name];
        });
        this.paginar(1,10);
      }
    );
    
  }
  
  buscaBairros(){ 
    this.bairros = ['Bairro'];
    this.bairro = 'Bairro';
    this.leadsService.getBairros(this.uf,this.cidade).subscribe(
      bairros => {
        bairros.forEach(role => {
          this.bairros = [...this.bairros, role.name];
        });
        this.paginar(1,10);
      }
    );
  }

  


}
