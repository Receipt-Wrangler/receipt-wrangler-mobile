import { inject } from '@angular/core';
import { CanActivateFn } from '@angular/router';
import { Store } from '@ngxs/store';
import { ServerState } from '../store/server.state';

export const homeserverGuard: CanActivateFn = (route, state) => {
  const store = inject(Store);
  const serverUrl = store.selectSnapshot(ServerState.url);
  // TODO: reroute back to configure homeserver screen

  return !!serverUrl;
};
