import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { RouteReuseStrategy } from '@angular/router';
import { Config, IonicModule, IonicRouteStrategy } from '@ionic/angular';
import {
  ApiModule,
  AuthService,
  CategoryService,
  CommentService,
  Configuration,
  DashboardService,
  FeatureConfigService,
  GroupsService,
  InputModule,
  NotificationsService,
  ReceiptImageService,
  ReceiptService,
  SearchService,
  SnackbarService,
  TagService,
  UserPreferencesService,
  UserService,
} from '@receipt-wrangler/receipt-wrangler-core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { StoreModule } from './store/store.module';
import { HomeserverInterceptor } from './homeserver.interceptor';
import { ToastService } from './services/toast.service';
import { FeatureConfigServiceWrapper } from './services/wrappers/feature-config-service-wrapper.service';
import {
  AuthServiceWrapper,
  CategoryServiceWrapper,
  CommentServiceWrapper,
  DashboardServiceWrapper,
  GroupsServiceWrapper,
  NotificationsServiceWrapper,
  ReceiptImageServiceWrapper,
  ReceiptServiceWrapper,
  SearchServiceWrapper,
  TagServiceWrapper,
  UserPreferenceServiceWrapper,
  UserServiceWrapper,
} from './services/wrappers';

@NgModule({
  declarations: [AppComponent],
  imports: [
    ApiModule.forRoot(() => {
      return new Configuration({
        withCredentials: true,
      });
    }),
    AppRoutingModule,
    BrowserAnimationsModule,
    BrowserModule,
    HttpClientModule,
    InputModule,
    IonicModule.forRoot(),
    MatSnackBarModule,
    StoreModule,
  ],
  providers: [
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: HomeserverInterceptor,
      multi: true,
    },
    {
      provide: SnackbarService,
      useClass: ToastService,
    },
    {
      provide: AuthService,
      useClass: AuthServiceWrapper,
    },
    {
      provide: CategoryService,
      useClass: CategoryServiceWrapper,
    },
    {
      provide: CommentService,
      useClass: CommentServiceWrapper,
    },
    {
      provide: DashboardService,
      useClass: DashboardServiceWrapper,
    },
    {
      provide: FeatureConfigService,
      useClass: FeatureConfigServiceWrapper,
    },
    {
      provide: GroupsService,
      useClass: GroupsServiceWrapper,
    },
    {
      provide: NotificationsService,
      useClass: NotificationsServiceWrapper,
    },
    {
      provide: ReceiptImageService,
      useClass: ReceiptImageServiceWrapper,
    },
    {
      provide: ReceiptService,
      useClass: ReceiptServiceWrapper,
    },
    {
      provide: SearchService,
      useClass: SearchServiceWrapper,
    },
    {
      provide: TagService,
      useClass: TagServiceWrapper,
    },
    {
      provide: UserPreferencesService,
      useClass: UserPreferenceServiceWrapper,
    },
    {
      provide: UserService,
      useClass: UserServiceWrapper,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
