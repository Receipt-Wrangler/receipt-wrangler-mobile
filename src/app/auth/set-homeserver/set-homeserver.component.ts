import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { Store } from '@ngxs/store';
import {
  FeatureConfigService,
  SnackbarService,
} from '@receipt-wrangler/receipt-wrangler-core';
import { catchError, of, take, tap } from 'rxjs';
import { ServerState } from 'src/app/store/server.state';
import { SetServerUrl } from 'src/app/store/server.state.actions';

@Component({
  selector: 'app-set-homeserver',
  templateUrl: './set-homeserver.component.html',
  styleUrls: ['./set-homeserver.component.scss'],
})
export class SetHomeserverComponent implements OnInit {
  public form: FormGroup = new FormGroup({});

  constructor(
    private formBuilder: FormBuilder,
    private store: Store,
    private featureConfigService: FeatureConfigService,
    private router: Router,
    private snackbarService: SnackbarService
  ) {}

  public ngOnInit() {
    this.initForm();
  }

  private initForm(): void {
    this.form.addControl(
      'url',
      this.formBuilder.control(this.store.selectSnapshot(ServerState.url), {
        validators: [Validators.required],
      })
    );
  }

  public submit(): void {
    if (this.form.valid) {
      this.store.dispatch(new SetServerUrl(this.form.value.url));
      this.featureConfigService
        .getFeatureConfig()
        .pipe(
          take(1),
          tap(() => {
            this.snackbarService.success('Successfully connected to server');
            this.router.navigate(['/auth', 'login']);
          }),
          catchError((err) => {
            this.snackbarService.error("Couldn't connect to server");
            this.store.dispatch(new SetServerUrl(''));
            return of(err);
          })
        )
        .subscribe();
    }
  }
}
