import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AuthModule as CoreAuthModule,
  InputModule,
} from '@receipt-wrangler/receipt-wrangler-core';

import { AuthRoutingModule } from './auth-routing.module';
import { MobileAuthFormComponent } from './mobile-auth-form/mobile-auth-form.component';

@NgModule({
  declarations: [MobileAuthFormComponent],
  imports: [CoreAuthModule, CommonModule, AuthRoutingModule, InputModule],
})
export class AuthModule {}
