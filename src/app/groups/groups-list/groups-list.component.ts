import { Component } from '@angular/core';
import { Select } from '@ngxs/store';
import { Group, GroupState } from '@receipt-wrangler/receipt-wrangler-core';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-groups-list',
  templateUrl: './groups-list.component.html',
  styleUrls: ['./groups-list.component.scss'],
})
export class GroupsListComponent {
  @Select(GroupState.groups) public groups!: Observable<Group[]>;
}
