import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { ColorsService } from '../../../shared/colors/colors.service';
import {GraficosService} from '../graficos.service';

@Component({
  selector: 'app-leads-clientes',
  templateUrl: './leads-clientes.component.html',
  styleUrls: ['./leads-clientes.component.scss']
})
export class LeadsClientesComponent implements OnInit {

  labels = []
  cliente = '';
  lead = '';
  barData = {
    labels : ['Lead X Cliente'],
    datasets: [
      {label:'',data: []},
      {label:'',data: []}
    ]
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
    me.cliente = '';
    this.graficosService.getGraficoClienteLead()
      .subscribe(
        leads => {
          
          me.barData.datasets =  [
            {label:'Lead',data:[leads[0].lead]},
            {label:'Cliente',data:[leads[0].cliente]}            
          ]
          me.ref.markForCheck();
        },
        error => console.log('erro')
    );
  }


}
