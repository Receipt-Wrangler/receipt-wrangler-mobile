import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UntilDestroy, untilDestroyed } from '@ngneat/until-destroy';
import { Store } from '@ngxs/store';
import {
  AppInitService,
  AuthService,
  AuthState,
  FeatureConfigService,
} from '@receipt-wrangler/receipt-wrangler-core';
import {
  catchError,
  firstValueFrom,
  from,
  of,
  switchMap,
  take,
  tap,
} from 'rxjs';
import { HOME_ROUTE } from './constants';

@UntilDestroy()
@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  constructor(
    private authService: AuthService,
    private appInitService: AppInitService,
    private featureConfigService: FeatureConfigService,
    private router: Router,
    private store: Store
  ) {}

  public ngOnInit(): void {
    this.getAppData();
    this.featureConfigService.getFeatureConfig().pipe().subscribe();
  }

  private getAppData(): void {
    this.store
      .select(AuthState.isLoggedIn)
      .pipe(
        untilDestroyed(this),
        switchMap(() => this.authService.getNewRefreshToken()),
        switchMap(() => {
          return this.appInitService.initAppData();
        }),
        catchError((err) => {
          this.router.navigate([HOME_ROUTE]);
          return of(err);
        })
      )
      .subscribe();
  }
}
