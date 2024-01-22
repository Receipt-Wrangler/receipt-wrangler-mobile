import { ModuleWithProviders } from '@angular/core';
import { Configuration } from './configuration';
import { HttpClient } from '@angular/common/http';
import * as i0 from "@angular/core";
export declare class ApiModule {
    static forRoot(configurationFactory: () => Configuration): ModuleWithProviders<ApiModule>;
    constructor(parentModule: ApiModule, http: HttpClient);
    static ɵfac: i0.ɵɵFactoryDeclaration<ApiModule, [{ optional: true; skipSelf: true; }, { optional: true; }]>;
    static ɵmod: i0.ɵɵNgModuleDeclaration<ApiModule, never, never, never>;
    static ɵinj: i0.ɵɵInjectorDeclaration<ApiModule>;
}
