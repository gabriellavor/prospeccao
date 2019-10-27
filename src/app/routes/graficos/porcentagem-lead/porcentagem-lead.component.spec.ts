import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PorcentagemLeadComponent } from './porcentagem-lead.component';

describe('PorcentagemLeadComponent', () => {
  let component: PorcentagemLeadComponent;
  let fixture: ComponentFixture<PorcentagemLeadComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PorcentagemLeadComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PorcentagemLeadComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
