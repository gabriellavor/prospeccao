import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RamoAtividadeComponent } from './ramo-atividade.component';

describe('RamoAtividadeComponent', () => {
  let component: RamoAtividadeComponent;
  let fixture: ComponentFixture<RamoAtividadeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RamoAtividadeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RamoAtividadeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
