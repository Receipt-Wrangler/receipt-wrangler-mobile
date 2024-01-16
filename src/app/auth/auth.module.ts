import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AuthFormUtil,
  ButtonModule,
  AuthModule as CoreAuthModule,
  DirectivesModule,
  InputModule,
  PipesModule,
} from '@receipt-wrangler/receipt-wrangler-core';

import { AuthRoutingModule } from './auth-routing.module';
import { MobileAuthFormComponent } from './mobile-auth-form/mobile-auth-form.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SetHomeserverComponent } from './set-homeserver/set-homeserver.component';
import { IonicModule } from '@ionic/angular';
import { SharedUiModule } from '../shared-ui/shared-ui.module';

@NgModule({
  declarations: [MobileAuthFormComponent, SetHomeserverComponent],
  imports: [
    AuthRoutingModule,
    ButtonModule,
    CommonModule,
    CoreAuthModule,
    DirectivesModule,
    InputModule,
    IonicModule,
    PipesModule,
    ReactiveFormsModule,
    SharedUiModule,
  ],
  providers: [AuthFormUtil],
})
export class AuthModule {}
