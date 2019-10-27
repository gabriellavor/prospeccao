import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VisualizarLeadsComponent } from './visualizar-leads.component';

describe('VisualizarLeadsComponent', () => {
  let component: VisualizarLeadsComponent;
  let fixture: ComponentFixture<VisualizarLeadsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VisualizarLeadsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VisualizarLeadsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
