import { Injectable } from '@angular/core';
import {Router, CanActivate,ActivatedRouteSnapshot,RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs/Observable';

@Injectable()
export class AuthGuardService implements CanActivate{

  constructor(private router:Router) { }

  canActivate(route:ActivatedRouteSnapshot,state:RouterStateSnapshot): Observable<boolean> | boolean{
    let usuario = localStorage.getItem("usuario");
    if(usuario != undefined && usuario != ''){
      return true;
    }
    this.router.navigate(['login']);
    return false;
  }

}
