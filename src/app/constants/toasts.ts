import { ToastOptions } from '@ionic/angular';

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
