import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { MobileAuthFormComponent } from './mobile-auth-form.component';
import {
  ApiModule,
  AuthFormUtil,
} from '@receipt-wrangler/receipt-wrangler-core';
import { NgxsModule } from '@ngxs/store';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { InjectionToken } from '@angular/core';

describe('MobileAuthFormComponent', () => {
  let component: MobileAuthFormComponent;
  let fixture: ComponentFixture<MobileAuthFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [MobileAuthFormComponent],
      imports: [
        ApiModule,
        IonicModule.forRoot(),
        NgxsModule.forRoot([]),
        HttpClientTestingModule,
      ],
      providers: [
        AuthFormUtil,
        {
          provide: new InjectionToken('MatSnackBar'),
          useValue: {},
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
