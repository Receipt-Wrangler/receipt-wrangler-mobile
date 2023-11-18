import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { authRoutes } from '@receipt-wrangler/receipt-wrangler-core';
import { MobileAuthFormComponent } from './mobile-auth-form/mobile-auth-form.component';
import { SetHomeserverComponent } from './set-homeserver/set-homeserver.component';
import { homeserverGuard } from '../guards/homeserver.guard';

const routes: Routes = [
  {
    path: 'homeserver',
    component: SetHomeserverComponent,
  },
  ...authRoutes,
];

const loginRoute = routes.find((route) => route.path === 'login');
if (loginRoute) {
  loginRoute.component = MobileAuthFormComponent;
  loginRoute.canActivate = [homeserverGuard];
}

const signUpRoute = routes.find((route) => route.path === 'sign-up');
if (signUpRoute) {
  signUpRoute.component = MobileAuthFormComponent;
  signUpRoute.canActivate = [homeserverGuard];
}

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AuthRoutingModule {}
