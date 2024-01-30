import { EnvironmentProviders, Provider } from '@angular/core';
import { optionsConfig } from './ngx-mask.config';
export declare function provideNgxMask(configValue?: optionsConfig | (() => optionsConfig)): Provider[];
export declare function provideEnvironmentNgxMask(configValue?: optionsConfig | (() => optionsConfig)): EnvironmentProviders;
