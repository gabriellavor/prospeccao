import { NgModule } from '@angular/core';
import { ClientesComponent } from './clientes/clientes.component';
import { SharedModule } from '../../shared/shared.module';
import { Routes, RouterModule } from '@angular/router';
import { ClientesService } from './clientes.service';
import { HttpModule } from '@angular/http';
import { ClientePaginacaoComponent } from './cliente-paginacao/cliente-paginacao.component';
import { IncluirClientesComponent } from './incluir-clientes/incluir-clientes.component';
import { ImportarClientesComponent } from './importar-clientes/importar-clientes.component';


const routes: Routes = [
   	{ path: '', redirectTo: 'clientes' },
    { path: 'clientes', component: ClientesComponent },
    { path: 'incluir-clientes', component: IncluirClientesComponent },
    { path: 'importar-clientes', component: ImportarClientesComponent }
];

@NgModule({
    imports: [
    	SharedModule,
        RouterModule.forChild(routes),
        HttpModule
    ],
    declarations: [ClientesComponent, ClientePaginacaoComponent, IncluirClientesComponent, ImportarClientesComponent],
    exports: [
        RouterModule
    ],
    providers:[
        ClientesService
    ]
})
export class ClientesModule { }