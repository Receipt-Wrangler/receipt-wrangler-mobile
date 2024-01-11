import { TestBed } from '@angular/core/testing';

import { HomeserverInterceptor } from './homeserver.interceptor';
import { NgxsModule } from '@ngxs/store';

describe('HomeserverInterceptor', () => {
  beforeEach(() =>
    TestBed.configureTestingModule({
      imports: [NgxsModule.forRoot([])],
      providers: [HomeserverInterceptor],
    })
  );

  it('should be created', () => {
    const interceptor: HomeserverInterceptor = TestBed.inject(
      HomeserverInterceptor
    );
    expect(interceptor).toBeTruthy();
  });
});
