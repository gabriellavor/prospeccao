import { NgModule } from '@angular/core';
import { SharedModule } from '../../shared/shared.module';
import { Routes, RouterModule } from '@angular/router';
import { HttpModule } from '@angular/http';
import { ConfiguracaoService } from './configuracao.service';
import { ConfiguracaoComponent } from './configuracao/configuracao.component';

const routes: Routes = [
  { path: '', redirectTo: 'configuracao' },
  { path: 'configuracao', component: ConfiguracaoComponent }
];

@NgModule({
 imports: [
   SharedModule,
     RouterModule.forChild(routes),
     HttpModule
 ],
 declarations: [ConfiguracaoComponent],
 exports: [
     RouterModule
 ],
  providers:[
      ConfiguracaoService
  ]
})
export class ConfiguracaoModule { }