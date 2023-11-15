import {
  Component,
  Injector,
  OnInit,
  ViewChild,
  runInInjectionContext,
} from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { Store } from '@ngxs/store';
import {
  AuthForm,
  AuthFormUtil,
} from '@receipt-wrangler/receipt-wrangler-core';
import { catchError, of, take, tap } from 'rxjs';
import { SetServerUrl } from 'src/app/store/server.state.actions';

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
    private authFormUtil: AuthFormUtil
  ) {}

  public ngOnInit() {
    this.initHomeserverUrlFormControl();
  }

  private initHomeserverUrlFormControl(): void {
    this.homeserverUrlFormControl = this.formBuilder.control('', {
      validators: [Validators.required, Validators.pattern(/https?:\/\/.*/)],
    });
  }

  public submit(): void {
    if (this.authForm.form.valid && this.homeserverUrlFormControl.valid) {
      this.store.dispatch(
        new SetServerUrl(this.homeserverUrlFormControl.value)
      );

      this.authFormUtil
        .getSubmitObservable(this.authForm.form, this.authForm.isSignUp.value)
        .pipe(
          take(1),
          catchError((err) => {
            this.store.dispatch(new SetServerUrl(''));
            return of(err);
          })
        )
        .subscribe();
    }
  }
}
