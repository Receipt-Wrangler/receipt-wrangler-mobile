import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { authRoutes } from '@receipt-wrangler/receipt-wrangler-core';
import { MobileAuthFormComponent } from './mobile-auth-form/mobile-auth-form.component';

const routes: Routes = [...authRoutes];

const loginRoute = routes.find((route) => route.path === 'login');
if (loginRoute) {
  loginRoute.component = MobileAuthFormComponent;
}

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AuthRoutingModule {}
