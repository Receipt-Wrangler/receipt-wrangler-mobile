import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { homeserverGuard } from './guards/homeserver.guard';

const routes: Routes = [
  // {
  //   path: '',
  //   canActivate: [homeserverGuard],
  //   loadChildren: () =>
  //     import('./tabs/tabs.module').then((m) => m.TabsPageModule),
  // },
  {
    path: 'auth',
    canActivate: [],
    loadChildren: () => import('./auth/auth.module').then((m) => m.AuthModule),
  },
  {
    path: '',
    redirectTo: '/auth/homeserver',
    pathMatch: 'full',
  },
];
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
