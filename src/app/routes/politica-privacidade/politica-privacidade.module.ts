import { NgModule } from '@angular/core';
import { PoliticaPrivacidadeComponent } from './politica-privacidade/politica-privacidade.component';
import { SharedModule } from '../../shared/shared.module';
import { Routes, RouterModule } from '@angular/router';
import { HttpModule } from '@angular/http';

const routes: Routes = [
  { path: '', redirectTo: 'politica-privacidade' },
  { path: 'politica-privacidade', component: PoliticaPrivacidadeComponent },
 ];
 
 @NgModule({
  imports: [
    SharedModule,
      RouterModule.forChild(routes),
      HttpModule
  ],
  declarations: [PoliticaPrivacidadeComponent],
  exports: [
      RouterModule
  ]
 })
 
export class PoliticaPrivacidadeModule { }
