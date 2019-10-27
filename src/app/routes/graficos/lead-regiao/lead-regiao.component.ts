import { Component, OnInit,ChangeDetectorRef } from '@angular/core';
import { ColorsService } from '../../../shared/colors/colors.service';
import {GraficosService} from '../graficos.service';


@Component({
  selector: 'app-lead-regiao',
  templateUrl: './lead-regiao.component.html',
  styleUrls: ['./lead-regiao.component.scss']
})
export class LeadRegiaoComponent implements OnInit {

  leadestado = []
  leadcidade = []
  leadbairro = []
 
  barDataEstado = {
    labels: [],
    datasets: [
      {label:'',data: []}]
  };

  barDataCidade = {
    labels: [],
    datasets: [
      {label:'',data: []}]
  };

  barDataBairro = {
    labels: [],
    datasets: [
      {label:'',data: []}]
  };

  barColorsEstado = [
    {
        backgroundColor: this.colors.byName('info'),
        borderColor: this.colors.byName('info'),
        pointHoverBackgroundColor: this.colors.byName('info'),
        pointHoverBorderColor: this.colors.byName('info')
    }
  ];

  barColorsCidade = [
    {
        backgroundColor: this.colors.byName('warning'),
        borderColor: this.colors.byName('warning'),
        pointHoverBackgroundColor: this.colors.byName('warning'),
        pointHoverBorderColor: this.colors.byName('warning')
    }
  ];

  barColorsBairro = [
    {
        backgroundColor: this.colors.byName('danger'),
        borderColor: this.colors.byName('danger'),
        pointHoverBackgroundColor: this.colors.byName('danger'),
        pointHoverBorderColor: this.colors.byName('danger')
    }
  ];

  barOptions = {
    scaleShowVerticalLines: false,
    responsive: true,
    scales: {
      yAxes: [{
          ticks: {
              beginAtZero: true
          }
      }]
  }
  };

  barOptionsBairro = {
    scaleShowVerticalLines: false,
    responsive: true,
    scales:{
      xAxes: [{
        ticks: {
            // Show all labels
            autoSkip: false,
            callback: function(tick) {
                var characterLimit = 10;
                if (tick.length >= characterLimit) {
                    return tick.slice(0, tick.length).substring(0, characterLimit - 1).trim() + '...';;
                }
                return tick;
            }
        }
    }]
    },
    tooltips: {
      callbacks: {
        title: function(tooltipItem){
          return this._data.labels[tooltipItem[0].index];
        }
      }
    }    
  };


  constructor( private graficosService:GraficosService, public colors: ColorsService, public ref:ChangeDetectorRef) { }

  ngOnInit() {
    this.buscaGraficoEstado();    
    this.buscaGraficoCidade();
    this.buscaGraficoBairro();
  }

  buscaGraficoEstado(){
    let me = this;
    
    me.barDataEstado.labels = []
    
    me.leadestado = []
    me.barDataEstado = {
      labels: [],
      datasets: [
        {label:'',data: []}
      ]
    };

    this.graficosService.getGraficoEstado()
      .subscribe(
        leads => {
          leads.forEach(role => {
            me.barDataEstado.labels.push(role.lead_uf);
            me.leadestado.push(role.qtd);
          });
          me.barDataEstado.datasets =  [
            {label:'Lead',data:me.leadestado}
          ]          
          me.ref.markForCheck();
          
        },
        error => console.log('erro')
    );
  }

  buscaGraficoCidade(){
    let me = this;
    
    me.barDataCidade.labels = []
    
    me.leadcidade = []
    me.barDataCidade = {
      labels: [],
      datasets: [
        {label:'',data: []}
      ]
    };

    this.graficosService.getGraficoCidade()
      .subscribe(
        leads => {
          leads.forEach(role => {
            me.barDataCidade.labels.push(role.lead_cidade);
            me.leadcidade.push(role.qtd);
          });
          me.barDataCidade.datasets =  [
            {label:'Lead',data:me.leadcidade}
          ]          
          me.ref.markForCheck();
          
        },
        error => console.log('erro')
    );
  }

  buscaGraficoBairro(){
    let me = this;
    
    me.barDataBairro.labels = []
    
    me.leadbairro = []
    me.barDataBairro = {
      labels: [],
      datasets: [
        {label:'',data: []}
      ]
    };

    this.graficosService.getGraficoBairro()
      .subscribe(
        leads => {
          leads.forEach(role => {
            me.barDataBairro.labels.push(role.lead_bairro);
            me.leadbairro.push(role.qtd);
          });
          me.barDataBairro.datasets =  [
            {label:'Lead',data:me.leadbairro}
          ]          
          me.ref.markForCheck();
          
        },
        error => console.log('erro')
    );
  }


}
