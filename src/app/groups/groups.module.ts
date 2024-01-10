import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { GroupsRoutingModule } from './group-routing.module';
import { GroupsListComponent } from './groups-list/groups-list.component';

@NgModule({
  declarations: [GroupsListComponent],
  imports: [CommonModule],
  exports: [GroupsRoutingModule],
})
export class GroupsModule {}
