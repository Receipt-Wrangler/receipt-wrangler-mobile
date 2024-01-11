import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { GroupsRoutingModule } from './group-routing.module';
import { GroupsListComponent } from './groups-list/groups-list.component';
import { IonicModule } from '@ionic/angular';

@NgModule({
  declarations: [GroupsListComponent],
  imports: [CommonModule, IonicModule],
  exports: [GroupsRoutingModule],
})
export class GroupsModule {}
