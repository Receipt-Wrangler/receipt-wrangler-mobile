import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { RouteReuseStrategy } from '@angular/router';
import { Config, IonicModule, IonicRouteStrategy } from '@ionic/angular';
import {
  ApiModule,
  Configuration,
  InputModule,
  SnackbarService,
} from '@receipt-wrangler/receipt-wrangler-core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { StoreModule } from './store/store.module';
import { HomeserverInterceptor } from './homeserver.interceptor';
import { ToastService } from './services/toast.service';

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
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
