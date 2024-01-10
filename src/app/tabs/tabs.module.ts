import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';

import { TabsComponent } from './tabs.compnent';

@NgModule({
  imports: [IonicModule, CommonModule, FormsModule],
  declarations: [TabsComponent],
})
export class TabsPageModule {}
