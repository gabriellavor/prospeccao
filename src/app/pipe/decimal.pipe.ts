import {Pipe, PipeTransform} from "@angular/core";
 
@Pipe({name: 'decimalMask'})
export class DecimalPipe implements PipeTransform{
 
    transform(value:string){
       if(value){
            value = value.toString();
            if(value != undefined && value != null){
                return parseInt(value).toFixed(2);
            } 
        }
        return value;
    }
}