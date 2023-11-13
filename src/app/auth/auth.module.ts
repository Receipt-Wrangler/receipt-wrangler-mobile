import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthModule as CoreAuthModule } from '@receipt-wrangler/receipt-wrangler-core';

import { AuthRoutingModule } from './auth-routing.module';
import { MobileAuthFormComponent } from './auth-form/mobile-auth-form.component';

@NgModule({
  declarations: [MobileAuthFormComponent],
  imports: [CoreAuthModule, CommonModule, AuthRoutingModule],
})
export class AuthModule {}
