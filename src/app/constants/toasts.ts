import { ToastOptions } from '@ionic/angular';
import { SnackbarService } from '@receipt-wrangler/receipt-wrangler-core';
import { ToastService } from '../services/toast.service';

export const DEFAULT_TOAST_CONFIG: ToastOptions = {
  position: 'top',
  duration: 3000,
  buttons: [
    {
      side: 'end',
      icon: 'close',
      role: 'cancel',
    },
  ],
};

export const TOAST_PROVIDER = {
  provide: SnackbarService,
  useClass: ToastService,
};
