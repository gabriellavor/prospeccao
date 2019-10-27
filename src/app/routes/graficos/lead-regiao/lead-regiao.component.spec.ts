import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LeadRegiaoComponent } from './lead-regiao.component';

describe('LeadRegiaoComponent', () => {
  let component: LeadRegiaoComponent;
  let fixture: ComponentFixture<LeadRegiaoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LeadRegiaoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LeadRegiaoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
