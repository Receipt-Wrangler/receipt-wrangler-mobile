import { Component, OnInit } from '@angular/core';
import { FeatureConfigService } from '@receipt-wrangler/receipt-wrangler-core';

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
