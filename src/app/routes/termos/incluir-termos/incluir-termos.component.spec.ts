import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IncluirTermosComponent } from './incluir-termos.component';

describe('IncluirTermosComponent', () => {
  let component: IncluirTermosComponent;
  let fixture: ComponentFixture<IncluirTermosComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IncluirTermosComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IncluirTermosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
