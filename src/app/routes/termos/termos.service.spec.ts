import { TestBed, inject } from '@angular/core/testing';

import { TermosService } from './termos.service';

describe('TermosService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [TermosService]
    });
  });

  it('should be created', inject([TermosService], (service: TermosService) => {
    expect(service).toBeTruthy();
  }));
});
