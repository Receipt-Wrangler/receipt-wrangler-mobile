import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';
import { InputComponent } from './input/input.component';
import { ReactiveFormsModule } from '@angular/forms';
import { ButtonComponent } from './button/button.component';

@NgModule({
  declarations: [InputComponent, ButtonComponent],
  imports: [CommonModule, IonicModule, ReactiveFormsModule],
  exports: [InputComponent, ButtonComponent],
})
export class SharedUiModule {}
