import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { AuthForm } from '@receipt-wrangler/receipt-wrangler-core';

@Component({
  selector: 'app-mobile-auth-form',
  templateUrl: './mobile-auth-form.component.html',
  styleUrls: ['./mobile-auth-form.component.scss'],
})
export class MobileAuthFormComponent implements OnInit {
  @ViewChild(AuthForm) public authForm!: AuthForm;

  public homeserverUrlFormControl!: FormControl;

  constructor(private formBuilder: FormBuilder) {}

  public ngOnInit() {
    this.initHomeserverUrlFormControl();
  }

  private initHomeserverUrlFormControl(): void {
    this.homeserverUrlFormControl = this.formBuilder.control('', {
      validators: [Validators.required],
    });
  }

  public submit(): void {
    console.warn('subbmitted');
    console.warn(this.homeserverUrlFormControl.value);
    console.warn(this.authForm.form.value);
  }
}
