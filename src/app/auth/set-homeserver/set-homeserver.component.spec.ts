import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { NgxsModule } from '@ngxs/store';
import {
  ApiModule,
  PipesModule,
} from '@receipt-wrangler/receipt-wrangler-core';
import { TOAST_PROVIDER } from 'src/app/constants';
import { SetHomeserverComponent } from './set-homeserver.component';

describe('SetHomeserverComponent', () => {
  let component: SetHomeserverComponent;
  let fixture: ComponentFixture<SetHomeserverComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SetHomeserverComponent],
      imports: [
        ApiModule,
        HttpClientTestingModule,
        IonicModule.forRoot(),
        NgxsModule.forRoot([]),
        PipesModule,
      ],
      providers: [TOAST_PROVIDER],
    }).compileComponents();

    fixture = TestBed.createComponent(SetHomeserverComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
