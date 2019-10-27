import { NgModule } from '@angular/core';
import { RamoAtividadeComponent } from './ramo-atividade/ramo-atividade.component';
import { SharedModule } from '../../shared/shared.module';
import { Routes, RouterModule } from '@angular/router';
import { GraficosService } from './graficos.service';
import { HttpModule } from '@angular/http';
import { ChartsModule as Ng2ChartsModule } from 'ng2-charts/ng2-charts';

import { NgSelectModule } from '@ng-select/ng-select';
import { FormsModule } from '@angular/forms';
import { LeadsClientesComponent } from './leads-clientes/leads-clientes.component';
import { PorcentagemLeadComponent } from './porcentagem-lead/porcentagem-lead.component';
import { LeadRegiaoComponent } from './lead-regiao/lead-regiao.component';

const routes: Routes = [
 { path: '', redirectTo: 'ramo-atividade' },
 { path: 'graficos', redirectTo: 'ramo-atividade' },
 { path: 'ramo-atividade', component: RamoAtividadeComponent },
 { path: 'cliente-leads', component: LeadsClientesComponent },
 { path: 'porcentagem-lead', component: PorcentagemLeadComponent } ,
 { path: 'lead-regiao', component: LeadRegiaoComponent } 
];

@NgModule({
 imports: [
    SharedModule,
    RouterModule.forChild(routes),
    HttpModule,
    Ng2ChartsModule,    
    NgSelectModule,
    FormsModule
 ],
 declarations: [RamoAtividadeComponent, LeadsClientesComponent, PorcentagemLeadComponent, LeadRegiaoComponent],
 exports: [
     RouterModule
 ],
 providers:[
    GraficosService
 ]
})
export class GraficoModule { }
