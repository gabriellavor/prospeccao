import { Component, OnInit,ChangeDetectorRef } from '@angular/core';
import { ColorsService } from '../../../shared/colors/colors.service';
import {GraficosService} from '../graficos.service';

@Component({
  selector: 'app-ramo-atividade',
  templateUrl: './ramo-atividade.component.html',
  styleUrls: ['./ramo-atividade.component.scss']
})
export class RamoAtividadeComponent implements OnInit {

  labels = []
  cliente = []
  lead = []
  ramo = 'Cliente';
  items = ['Cliente','Lead']
  barData = {
    labels: [],
    datasets: [
      {label:'',data: []},
      {label:'',data: []}]
  };

  barColors = [
    {
        backgroundColor: this.colors.byName('info'),
        borderColor: this.colors.byName('info'),
        pointHoverBackgroundColor: this.colors.byName('info'),
        pointHoverBorderColor: this.colors.byName('info')
    }, {
        backgroundColor: this.colors.byName('warning'),
        borderColor: this.colors.byName('warning'),
        pointHoverBackgroundColor: this.colors.byName('warning'),
        pointHoverBorderColor: this.colors.byName('warning')
    }
  ];

  barOptions = {
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
    this.buscaGrafico();    
  }

  buscaGrafico(){
    let me = this;
    
    me.barData.labels = []
    me.cliente = []
    me.lead = []
    me.barData = {
      labels: [],
      datasets: [
        {label:'',data: []},
        {label:'',data: []}]
    };
    this.graficosService.getRamoAtividade(me.ramo)
      .subscribe(
        leads => {
          leads.forEach(role => {
            me.barData.labels.push(role.descricao);
            me.cliente.push(role.cliente);
            me.lead.push(role.lead);
          });
          me.barData.datasets =  [
            {label:'Cliente',data:me.cliente},
            {label:'Lead',data:me.lead}
          ]          
          me.ref.markForCheck();
          
        },
        error => console.log('erro')
    );
  }


}
