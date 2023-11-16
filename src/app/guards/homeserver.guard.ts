import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { Store } from '@ngxs/store';
import { ServerState } from '../store/server.state';

export const homeserverGuard: CanActivateFn = (route, state) => {
  const store = inject(Store);
  const router = inject(Router);
  const serverUrl = store.selectSnapshot(ServerState.url);

  if (!serverUrl) {
    router.navigate(['']);
  }

  return !!serverUrl;
};
