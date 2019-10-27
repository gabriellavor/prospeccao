import { Component, OnInit } from '@angular/core';
import {ElementRef, ViewChild} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {ClientesService} from '../clientes.service';

@Component({
  selector: 'app-importar-clientes',
  templateUrl: './importar-clientes.component.html',
  styleUrls: ['./importar-clientes.component.scss']
})
export class ImportarClientesComponent implements OnInit {

  form: FormGroup;
  loading: boolean = false;
  retorno:any = {
    qtd:0,
    qtd_nao:0,
    erros:'',
    sucesso:false,
    envio:false
  }

  @ViewChild('fileInput') fileInput: ElementRef;

  constructor(private fb: FormBuilder,private clientesService:ClientesService) {
    this.createForm();
  }
  
  ngOnInit(){}

  createForm() {
    this.form = this.fb.group({
      avatar: ['', Validators.required],
    });
  }

  onFileChange(event) {
    let reader = new FileReader();
    if(event.target.files && event.target.files.length > 0) {
      let file = event.target.files[0];
      reader.readAsDataURL(file);
      reader.onload = () => {
        this.form.get('avatar').setValue({
          filetype: file.type,
          value: reader.result.split(',')[1]
        })
      };
    }
  }

  onSubmit() {
    let me = this;
    const formModel = this.form.value;
    this.loading = true;

    me.retorno.envio = false;
    if(formModel.avatar != undefined && formModel.avatar.value != ''){
      this.clientesService.uploadCSV(formModel.avatar.value).subscribe(
        data => {
          if(data.sucesso == true){
            me.retorno.qtd = data.qtd;
            me.retorno.qtd_nao = data.nao_incluidos;
            me.retorno.sucesso = true;
          }else{
            me.retorno.qtd = 0;
            me.retorno.qtd_nao = data.nao_incluidos;
            me.retorno.sucesso = false;
          }
          me.clearFile();
          me.retorno.erros = data.erros;
          me.retorno.envio = true;
          this.loading = false;
        }
      );
    }else{
      me.retorno.qtd = 0;
      me.retorno.qtd_nao = 0;
      me.retorno.sucesso = false;
      me.retorno.envio = true;
      this.loading = false;
    }
  }
  
  clearFile() {
    this.form.get('avatar').setValue(null);
    this.fileInput.nativeElement.value = '';
  }

}
