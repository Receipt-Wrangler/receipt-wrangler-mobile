import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';

import { TabsComponent } from './tabs.compnent';
import { RouterModule } from '@angular/router';

@NgModule({
  imports: [IonicModule, CommonModule, FormsModule, RouterModule],
  declarations: [TabsComponent],
})
export class TabsPageModule {}
