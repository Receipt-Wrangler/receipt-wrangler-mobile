import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgxsStoragePluginModule } from '@ngxs/storage-plugin';
import { NgxsModule } from '@ngxs/store';
import {
  AuthState,
  FeatureConfigState,
  GroupState,
} from '@receipt-wrangler/receipt-wrangler-core';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    NgxsModule.forRoot([AuthState, GroupState, FeatureConfigState]),
    NgxsStoragePluginModule.forRoot({
      key: ['groups', 'layout', 'receiptTable'],
    }),
  ],
})
export class StoreModule {}
