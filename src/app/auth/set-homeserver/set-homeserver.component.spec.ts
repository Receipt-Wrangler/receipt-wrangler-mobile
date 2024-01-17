import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { Router } from '@angular/router';
import { IonicModule } from '@ionic/angular';
import { NgxsModule, Store } from '@ngxs/store';
import {
  ApiModule,
  FeatureConfigService,
  PipesModule,
} from '@receipt-wrangler/receipt-wrangler-core';
import { of } from 'rxjs';
import { TOAST_PROVIDER } from 'src/app/constants';
import { ServerState } from 'src/app/store/server.state';
import { SetServerUrl } from 'src/app/store/server.state.actions';
import { SetHomeserverComponent } from './set-homeserver.component';

describe('SetHomeserverComponent', () => {
  let component: SetHomeserverComponent;
  let fixture: ComponentFixture<SetHomeserverComponent>;
  let store: Store;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SetHomeserverComponent],
      imports: [
        ApiModule,
        HttpClientTestingModule,
        IonicModule.forRoot(),
        NgxsModule.forRoot([ServerState]),
        PipesModule,
      ],
      providers: [TOAST_PROVIDER],
    }).compileComponents();

    store = TestBed.inject(Store);
    fixture = TestBed.createComponent(SetHomeserverComponent);
    component = fixture.componentInstance;
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should init form with no data', () => {
    component.ngOnInit();
    expect(component.form.value).toEqual({ url: '' });
  });

  it('should init form with stored url', () => {
    const url = 'https://example.com';
    store.reset({ server: { url } });

    component.ngOnInit();
    expect(component.form.value).toEqual({ url: url });
  });

  it('should init form with stored url', () => {
    const url = 'https://example.com';
    store.reset({ server: { url } });

    component.ngOnInit();
    expect(component.form.value).toEqual({ url: url });
  });

  it('should get navigate to login upon successful ping', () => {
    const url = 'https://example.com';
    store.reset({ server: { url } });

    const featureConfigServiceSpy = spyOn(
      TestBed.inject(FeatureConfigService),
      'getFeatureConfig'
    ).and.returnValue(of({}) as any);

    const router = TestBed.inject(Router);
    const routerSpy = spyOn(router, 'navigate');

    const storeSpy = spyOn(store, 'dispatch');

    component.ngOnInit();
    component.submit();

    expect(storeSpy).toHaveBeenCalledWith(new SetServerUrl(url));
    expect(featureConfigServiceSpy).toHaveBeenCalled();
    expect(routerSpy).toHaveBeenCalledWith(['/auth', 'login']);
  });

  it('should not attempt to get feature config', () => {
    const featureConfigServiceSpy = spyOn(
      TestBed.inject(FeatureConfigService),
      'getFeatureConfig'
    ).and.returnValue(of({}) as any);

    const router = TestBed.inject(Router);
    const routerSpy = spyOn(router, 'navigate');

    const storeSpy = spyOn(store, 'dispatch');

    component.ngOnInit();
    component.submit();

    expect(storeSpy).toHaveBeenCalledTimes(0);
    expect(featureConfigServiceSpy).toHaveBeenCalledTimes(0);
    expect(routerSpy).toHaveBeenCalledTimes(0);
  });
});
