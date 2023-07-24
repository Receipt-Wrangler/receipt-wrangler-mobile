import { Component, OnInit } from '@angular/core';
import { FeatureConfigService } from '@noah231515/receipt-wrangler-core';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  constructor(private featureConfigService: FeatureConfigService) {}
  ngOnInit(): void {
    this.featureConfigService.getFeatureConfig().pipe().subscribe();
  }
}
