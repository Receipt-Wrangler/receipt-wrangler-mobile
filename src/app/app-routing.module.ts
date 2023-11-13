import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    loadChildren: () =>
      import('./tabs/tabs.module').then((m) => m.TabsPageModule),
  },
  {
    path: 'auth',
    loadChildren: () =>
      import('@receipt-wrangler/receipt-wrangler-core').then(
        (m) => m.AuthModule
      ),
  },
  {
    path: '',
    redirectTo: '/auth/login',
    pathMatch: 'full',
  },
];
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
