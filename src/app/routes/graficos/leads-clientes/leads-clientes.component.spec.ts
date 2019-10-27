import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LeadsClientesComponent } from './leads-clientes.component';

describe('LeadsClientesComponent', () => {
  let component: LeadsClientesComponent;
  let fixture: ComponentFixture<LeadsClientesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LeadsClientesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LeadsClientesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
