import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TermosComponent } from './termos/termos.component';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { HttpModule } from '@angular/http';
import { TermosService } from './termos.service';
import { IncluirTermosComponent } from './incluir-termos/incluir-termos.component';

const routes: Routes = [
  { path: '', redirectTo: 'termos' },
  { path: 'termos', component: TermosComponent },
  { path: 'incluir-termos', component: IncluirTermosComponent },
];

@NgModule({
  imports: [
    SharedModule,
      RouterModule.forChild(routes),
      HttpModule
  ],
  exports: [
    RouterModule
  ],
  providers:[
    TermosService
  ],
  declarations: [TermosComponent, IncluirTermosComponent]
})
export class TermosModule { }
