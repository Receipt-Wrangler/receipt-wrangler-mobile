import { Injectable } from '@angular/core';
import { Action, Selector, State, StateContext } from '@ngxs/store';
import { SetServerUrl } from './server.state.actions';

export interface ServerStateInterface {
  url?: string;
}

@State<ServerStateInterface>({
  name: 'server',
  defaults: {
    url: '',
  },
})
@Injectable()
export class ServerState {
  @Selector()
  static url(state: ServerStateInterface): string | undefined {
    return state.url;
  }

  @Action(SetServerUrl)
  setServerUrl(
    { patchState }: StateContext<ServerStateInterface>,
    payload: SetServerUrl
  ) {
    patchState({
      url: payload.url,
    });
  }
}
