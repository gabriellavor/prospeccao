import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UsuarioPaginacaoComponent } from './usuario-paginacao.component';

describe('UsuarioPaginacaoComponent', () => {
  let component: UsuarioPaginacaoComponent;
  let fixture: ComponentFixture<UsuarioPaginacaoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UsuarioPaginacaoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UsuarioPaginacaoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
