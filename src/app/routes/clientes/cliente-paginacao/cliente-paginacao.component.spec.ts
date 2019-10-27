import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ClientePaginacaoComponent } from './cliente-paginacao.component';

describe('ClientePaginacaoComponent', () => {
  let component: ClientePaginacaoComponent;
  let fixture: ComponentFixture<ClientePaginacaoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClientePaginacaoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClientePaginacaoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
