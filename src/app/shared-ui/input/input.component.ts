import { Component } from '@angular/core';
import { InputComponent as CoreInputComponent } from '@receipt-wrangler/receipt-wrangler-core';

@Component({
  selector: 'wrangler-mobile-input',
  templateUrl: './input.component.html',
  styleUrls: ['./input.component.scss'],
})
export class InputComponent extends CoreInputComponent {}
