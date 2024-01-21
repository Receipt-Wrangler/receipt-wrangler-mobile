import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Store } from '@ngxs/store';
import {
  AuthService,
  Configuration,
} from '@receipt-wrangler/receipt-wrangler-core';
import { tap } from 'rxjs';
import { ServerState } from '../../store/server.state';

@Injectable({
  providedIn: 'root',
})
export class AuthServiceWrapper extends AuthService {
  constructor(
    httpClient: HttpClient,
    configuration: Configuration,
    private store: Store
  ) {
    super(httpClient, '', configuration);
    this.store.select(ServerState.url).pipe(
      tap((url) => {
        this.basePath = url;
      })
    );
  }
}
