import { Injectable, TemplateRef } from '@angular/core';
import { ToastController } from '@ionic/angular';
import { SnackbarServiceInterface } from '@receipt-wrangler/receipt-wrangler-core';
import { DEFAULT_TOAST_CONFIG } from '../constants';

@Injectable({
  providedIn: 'root',
})
export class ToastService implements SnackbarServiceInterface {
  constructor(private toastController: ToastController) {}

  public error(message: string): void {
    this.toastController
      .create({
        ...DEFAULT_TOAST_CONFIG,
        message: message,
        color: 'danger',
      })
      .then((toast) => toast.present());
  }

  public success(message: string): void {
    this.toastController
      .create({
        ...DEFAULT_TOAST_CONFIG,
        message: message,
        color: 'success',
      })
      .then((toast) => toast.present());
  }

  public successFromTemplate(
    template: TemplateRef<any>,
    configOverrides?: any
  ) {
    throw new Error('Method not implemented.');
  }
}
