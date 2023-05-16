import { TestBed } from '@angular/core/testing';

import { PeriodFormServiceService } from './period-form-service.service';

describe('PeriodFormServiceService', () => {
  let service: PeriodFormServiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PeriodFormServiceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
