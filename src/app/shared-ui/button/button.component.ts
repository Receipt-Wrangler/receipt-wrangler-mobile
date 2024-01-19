import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'wrangler-mobile-button',
  templateUrl: './button.component.html',
  styleUrls: ['./button.component.scss'],
})
export class ButtonComponent {
  @Input() public buttonText: string = '';

  @Input() public expand: 'full' | 'block' | 'default' = 'default';

  @Input() public disabled: boolean = false;

  @Input() public type: 'button' | 'submit' | 'reset' = 'button';

  @Input() public color: string = 'primary';

  @Output() public clicked: EventEmitter<MouseEvent> =
    new EventEmitter<MouseEvent>();

  public emitClicked(event: MouseEvent): void {
    this.clicked.emit(event);
  }
}
