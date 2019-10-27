import { Component, OnInit } from '@angular/core';
import { ActivatedRoute} from '@angular/router';
import {LeadsService} from '../leads.service';
@Component({
  selector: 'app-visualizar-leads',
  templateUrl: './visualizar-leads.component.html',
  styleUrls: ['./visualizar-leads.component.scss']
})
export class VisualizarLeadsComponent implements OnInit {

  id:any;
  lead:any;

  constructor(
    private route: ActivatedRoute,private leadsService:LeadsService
  ) {
    this.lead = []; 
  }


  ngOnInit() {
    let me = this;
    this.id = this.route.snapshot.paramMap.get('id');
		this.leadsService.getLead(this.id)
      .subscribe(
        users => {me.lead = users;},
        error => console.log('erro')
      );
	}

}
