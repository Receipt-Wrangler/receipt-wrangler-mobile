import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { Store } from '@ngxs/store';
import { ServerState } from './store/server.state';

@Injectable()
export class HomeserverInterceptor implements HttpInterceptor {
  constructor(private store: Store) {}

  public intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler
  ): Observable<HttpEvent<unknown>> {
    const serverUrl = this.store.selectSnapshot(ServerState.url);
    if (serverUrl) {
    } else {
    }

    console.warn(request.url);
    const clone = request.clone({
      url: 'https://google.com',
    });
    return next.handle(clone);
  }
}
