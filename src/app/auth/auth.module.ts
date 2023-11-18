import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AuthFormUtil,
  ButtonModule,
  AuthModule as CoreAuthModule,
  InputModule,
  PipesModule,
} from '@receipt-wrangler/receipt-wrangler-core';

import { AuthRoutingModule } from './auth-routing.module';
import { MobileAuthFormComponent } from './mobile-auth-form/mobile-auth-form.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SetHomeserverComponent } from './set-homeserver/set-homeserver.component';

@NgModule({
  declarations: [MobileAuthFormComponent, SetHomeserverComponent],
  imports: [
    AuthRoutingModule,
    ButtonModule,
    CommonModule,
    CoreAuthModule,
    InputModule,
    ReactiveFormsModule,
    PipesModule,
  ],
  providers: [AuthFormUtil],
})
export class AuthModule {}
