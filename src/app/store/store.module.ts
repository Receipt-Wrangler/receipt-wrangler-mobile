import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgxsStoragePluginModule } from '@ngxs/storage-plugin';
import { NgxsModule } from '@ngxs/store';
import {
  AuthState,
  FeatureConfigState,
  GroupState,
} from '@receipt-wrangler/receipt-wrangler-core';
import { ServerState } from './server.state';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    NgxsModule.forRoot([
      AuthState,
      GroupState,
      FeatureConfigState,
      ServerState,
    ]),
    NgxsStoragePluginModule.forRoot({
      key: ['groups', 'layout', 'receiptTable', 'server'],
    }),
  ],
})
export class StoreModule {}
