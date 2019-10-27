import { Injectable } from '@angular/core';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../../environments/environment';
import { HttpClientModule,HttpClient } from '@angular/common/http';

@Injectable()
export class UserblockService {
    public userBlockVisible: boolean;
    url:any = environment.apiUrl;
    constructor(private httpClient:HttpClient) {
        this.userBlockVisible  = true;
    }

    getVisibility() {
        return this.userBlockVisible;
    }

    setVisibility(stat = true) {
        this.userBlockVisible = stat;
    }

    toggleVisibility() {
        this.userBlockVisible = !this.userBlockVisible;
    }

    getUserFacebook(userId): Observable<any> {
        try{
            let me = this;
            return this.httpClient.get(me.url+`facebook/`+userId)
                .map(res=> res)
                .catch(err=> Observable.throw(err.message));
        }catch(err){
            console.log(err.message);
        }
        
    }

    getUserLinkedin(): Observable<any> {
        let me = this;
        return this.httpClient.get(me.url+`linkedin/`)
            .map(res=> res)
            .catch(err=> Observable.throw(err.message));
    }

}
