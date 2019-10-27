import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UsuariosComponent } from './usuarios/usuarios.component';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { HttpModule } from '@angular/http';
import { UsuariosService } from './usuarios.service';
import { UsuarioPaginacaoComponent } from './usuario-paginacao/usuario-paginacao.component';
import { VisualizarUsuariosComponent } from './visualizar-usuarios/visualizar-usuarios.component';
import { IncluirUsuariosComponent } from './incluir-usuarios/incluir-usuarios.component';
import { EditarUsuariosComponent } from './editar-usuarios/editar-usuarios.component';

const routes: Routes = [
  { path: '', redirectTo: 'usuarios' },
  { path: 'usuarios', component: UsuariosComponent },
  { path: 'visualizar-usuarios/:id', component: VisualizarUsuariosComponent },
  { path: 'incluir-usuarios', component: IncluirUsuariosComponent },
  { path: 'editar-usuarios/:id', component: EditarUsuariosComponent }
];

@NgModule({
  imports: [
    SharedModule,
      RouterModule.forChild(routes),
      HttpModule
  ],
  declarations: [UsuariosComponent, UsuarioPaginacaoComponent, VisualizarUsuariosComponent, IncluirUsuariosComponent, EditarUsuariosComponent],
  exports: [
      RouterModule
  ],
  providers:[
    UsuariosService
  ]
})
export class UsuariosModule { }
