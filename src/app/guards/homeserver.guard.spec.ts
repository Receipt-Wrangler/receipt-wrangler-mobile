import { TestBed } from '@angular/core/testing';
import { CanActivateFn } from '@angular/router';

import { homeserverGuard } from './homeserver.guard';

describe('homeserverGuard', () => {
  const executeGuard: CanActivateFn = (...guardParameters) => 
      TestBed.runInInjectionContext(() => homeserverGuard(...guardParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeGuard).toBeTruthy();
  });
});
