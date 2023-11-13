import { TestBed } from '@angular/core/testing';

import { HomeserverInterceptor } from './homeserver.interceptor';

describe('HomeserverInterceptor', () => {
  beforeEach(() => TestBed.configureTestingModule({
    providers: [
      HomeserverInterceptor
      ]
  }));

  it('should be created', () => {
    const interceptor: HomeserverInterceptor = TestBed.inject(HomeserverInterceptor);
    expect(interceptor).toBeTruthy();
  });
});
