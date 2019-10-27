import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LeadPaginacaoComponent } from './lead-paginacao.component';

describe('LeadPaginacaoComponent', () => {
  let component: LeadPaginacaoComponent;
  let fixture: ComponentFixture<LeadPaginacaoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LeadPaginacaoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LeadPaginacaoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
