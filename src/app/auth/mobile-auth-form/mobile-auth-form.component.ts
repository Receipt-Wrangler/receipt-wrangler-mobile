import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { Store } from '@ngxs/store';
import {
  AuthForm,
  AuthFormUtil,
} from '@receipt-wrangler/receipt-wrangler-core';
import { take, tap } from 'rxjs';
import { ServerState } from 'src/app/store/server.state';

@Component({
  selector: 'app-mobile-auth-form',
  templateUrl: './mobile-auth-form.component.html',
  styleUrls: ['./mobile-auth-form.component.scss'],
})
export class MobileAuthFormComponent implements OnInit {
  @ViewChild(AuthForm) public authForm!: AuthForm;

  public homeserverUrlFormControl!: FormControl;

  constructor(
    private formBuilder: FormBuilder,
    private store: Store,
    private authFormUtil: AuthFormUtil,
    private router: Router
  ) {}

  public ngOnInit() {
    this.initHomeserverUrlFormControl();
  }

  private initHomeserverUrlFormControl(): void {
    this.homeserverUrlFormControl = this.formBuilder.control(
      this.store.selectSnapshot(ServerState.url)
    );
  }

  public submit(): void {
    if (this.authForm.form.valid) {
      this.authFormUtil
        .getSubmitObservable(this.authForm.form, this.authForm.isSignUp.value)
        .pipe(
          take(1),
          tap(() => {
            this.router.navigate(['/']);
          })
        )
        .subscribe();
    }
  }
}
