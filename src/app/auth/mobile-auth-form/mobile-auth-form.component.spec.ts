import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { IonicModule } from '@ionic/angular';
import { NgxsModule } from '@ngxs/store';
import {
  ApiModule,
  AuthFormUtil,
  PipesModule,
} from '@receipt-wrangler/receipt-wrangler-core';
import { of } from 'rxjs';
import { TOAST_PROVIDER } from 'src/app/constants';
import { MobileAuthFormComponent } from './mobile-auth-form.component';

describe('MobileAuthFormComponent', () => {
  let component: MobileAuthFormComponent;
  let fixture: ComponentFixture<MobileAuthFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [MobileAuthFormComponent],
      imports: [
        ApiModule,
        HttpClientTestingModule,
        IonicModule.forRoot(),
        NgxsModule.forRoot([]),
        PipesModule,
      ],
      providers: [
        AuthFormUtil,
        TOAST_PROVIDER,
        {
          provide: ActivatedRoute,
          useValue: {
            data: of({}),
          },
        },
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(MobileAuthFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
