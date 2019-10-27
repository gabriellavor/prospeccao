import { NgModule } from '@angular/core';
import { LeadsComponent } from './leads/leads.component';
import { SharedModule } from '../../shared/shared.module';
import { Routes, RouterModule } from '@angular/router';
import { LeadsService } from './leads.service';
import { HttpModule } from '@angular/http';
import { LeadPaginacaoComponent } from './lead-paginacao/lead-paginacao.component';
import { VisualizarLeadsComponent } from './visualizar-leads/visualizar-leads.component';


import { DecimalPipe } from '../../pipe/decimal.pipe'

import { NgSelectModule } from '@ng-select/ng-select';
import { FormsModule } from '@angular/forms';

const routes: Routes = [
 { path: '', redirectTo: 'leads' },
 { path: 'leads', component: LeadsComponent },
 { path: 'visualizar-leads/:id', component: VisualizarLeadsComponent },
];

@NgModule({
 imports: [
    SharedModule,
    RouterModule.forChild(routes),
    HttpModule,    
    NgSelectModule,
    FormsModule
 ],
 declarations: [LeadsComponent, LeadPaginacaoComponent,VisualizarLeadsComponent,DecimalPipe],
 exports: [
     RouterModule
 ],
 providers:[
     LeadsService
 ]
})
export class LeadsModule { }
