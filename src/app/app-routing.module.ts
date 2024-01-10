import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { homeserverGuard } from './guards/homeserver.guard';
import { TabsComponent } from './tabs/tabs.compnent';
import { TabsPageModule } from './tabs/tabs.module';

const routes: Routes = [
  {
    path: '',
    canActivate: [homeserverGuard],
    component: TabsComponent,
    children: [
      {
        path: 'groups',
        loadChildren: () =>
          import('./groups/groups.module').then((m) => m.GroupsModule),
      },
    ],
  },
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
  imports: [RouterModule.forRoot(routes), TabsPageModule],
  exports: [RouterModule],
})
export class AppRoutingModule {}
