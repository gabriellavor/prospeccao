import { Component, OnInit,ChangeDetectorRef } from '@angular/core';
import { ColorsService } from '../../../shared/colors/colors.service';
import {GraficosService} from '../graficos.service';

@Component({
  selector: 'app-porcentagem-lead',
  templateUrl: './porcentagem-lead.component.html',
  styleUrls: ['./porcentagem-lead.component.scss']
})
export class PorcentagemLeadComponent implements OnInit {

  labels = []
  cliente = []
  lead = []
  barData = {
    labels: [],
    datasets: [
      {label:'',data: []}
    ]
  };

  barColors = [
    {
        backgroundColor: this.colors.byName('info'),
        borderColor: this.colors.byName('info'),
        pointHoverBackgroundColor: this.colors.byName('info'),
        pointHoverBorderColor: this.colors.byName('info')
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

  constructor( private graficosService:GraficosService, public colors: ColorsService, public ref:ChangeDetectorRef) { }

  ngOnInit() {
    this.buscaGrafico();    
  }

  buscaGrafico(){
    let me = this;
    me.cliente = []
    this.graficosService.getGraficoPorcentagem()
      .subscribe(
        leads => {
          leads.forEach(role => {
            me.barData.labels.push(role.porcentagem);
            me.cliente.push(role.qtd);
          });
          me.barData.datasets =  [
            {label:'QTD',data:me.cliente}
          ]          
          //me.ref.markForCheck();
        },
        error => console.log('erro')
    );
  }

}
