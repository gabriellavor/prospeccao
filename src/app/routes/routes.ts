import { LayoutComponent } from '../layout/layout.component';
import { LoginComponent } from './pages/login/login.component';
import { RegisterComponent } from './pages/register/register.component';
import { RecoverComponent } from './pages/recover/recover.component';
import { LockComponent } from './pages/lock/lock.component';
import { MaintenanceComponent } from './pages/maintenance/maintenance.component';
import { Error404Component } from './pages/error404/error404.component';
import { Error500Component } from './pages/error500/error500.component';

import {AuthGuardService} from './guards/auth-guard.service';


export const routes = [

    {
        path: '',
        component: LayoutComponent,
        children: [
            { path: '', redirectTo: 'home', pathMatch: 'full' },
            { path: 'home', loadChildren: './home/home.module#HomeModule',canActivate:[AuthGuardService] },
            { path: 'clientes', loadChildren: './clientes/clientes.module#ClientesModule',canActivate:[AuthGuardService] },
            { path: 'leads', loadChildren: './leads/leads.module#LeadsModule',canActivate:[AuthGuardService] },
            { path: 'graficos', loadChildren: './graficos/grafico.module#GraficoModule',canActivate:[AuthGuardService] },
            { path: 'configuracao', loadChildren: './configuracao/configuracao.module#ConfiguracaoModule',canActivate:[AuthGuardService] },        
            { path: 'usuarios', loadChildren: './usuarios/usuarios.module#UsuariosModule',canActivate:[AuthGuardService] },
            { path: 'termos', loadChildren: './termos/termos.module#TermosModule',canActivate:[AuthGuardService] },
            { path: 'politica-privacidade', loadChildren: './politica-privacidade/politica-privacidade.module#PoliticaPrivacidadeModule',canActivate:[AuthGuardService] },
        ]
    },

    // Not lazy-loaded routes
    { path: 'login', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: 'recover', component: RecoverComponent },
    { path: 'lock', component: LockComponent },
    { path: 'maintenance', component: MaintenanceComponent },
    { path: '404', component: Error404Component },
    { path: '500', component: Error500Component },

    // Not found
    { path: '**', redirectTo: 'clientes' }

];
