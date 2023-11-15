import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { NEVER, Observable, throwError } from 'rxjs';
import { Store } from '@ngxs/store';
import { ServerState } from './store/server.state';
import { Router } from '@angular/router';

@Injectable()
export class HomeserverInterceptor implements HttpInterceptor {
  constructor(private store: Store, private router: Router) {}

  public intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler
  ): Observable<HttpEvent<unknown>> {
    const serverUrl = this.store.selectSnapshot(ServerState.url);

    if (serverUrl) {
      const urlParts = request.url.split('/');
      urlParts[0] = serverUrl;
      const url = urlParts.join('/');
      const clone = request.clone({
        url: url,
      });
      return next.handle(clone);
    } else {
      this.router.navigate(['']);
      return throwError(() => new Error('No server URL set'));
    }
  }
}
