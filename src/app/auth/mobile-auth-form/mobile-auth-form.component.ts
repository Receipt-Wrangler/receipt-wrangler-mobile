import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Store } from '@ngxs/store';
import {
  AppInitService,
  AuthForm,
  AuthFormUtil,
  UserValidators,
} from '@receipt-wrangler/receipt-wrangler-core';
import { switchMap, take, tap } from 'rxjs';
import { ServerState } from 'src/app/store/server.state';

@Component({
  selector: 'app-mobile-auth-form',
  templateUrl: './mobile-auth-form.component.html',
  styleUrls: ['./mobile-auth-form.component.scss'],
  providers: [UserValidators],
})
export class MobileAuthFormComponent extends AuthForm implements OnInit {
  @ViewChild(AuthForm) public authForm!: AuthForm;

  public homeserverUrlFormControl!: FormControl;

  constructor(
    private appInitService: AppInitService,
    protected override authFormUtil: AuthFormUtil,
    protected override formBuilder: FormBuilder,
    protected override route: ActivatedRoute,
    protected override router: Router,
    protected override store: Store,
    protected override userValidators: UserValidators
  ) {
    super(authFormUtil, formBuilder, route, router, store, userValidators);
  }

  public override ngOnInit() {
    super.ngOnInit();
    this.initHomeserverUrlFormControl();
  }

  private initHomeserverUrlFormControl(): void {
    this.homeserverUrlFormControl = this.formBuilder.control(
      this.store.selectSnapshot(ServerState.url)
    );
  }

  public override submit(): void {
    if (this.authForm.form.valid) {
      this.authFormUtil
        .getSubmitObservable(this.authForm.form, this.authForm.isSignUp.value)
        .pipe(
          take(1),
          switchMap(() => this.appInitService.initAppData()),
          tap(() => {
            this.router.navigate(['/']);
          })
        )
        .subscribe();
    }
  }
}
