import { PipeTransform } from '@angular/core';
import { IConfig } from './ngx-mask.config';
import * as i0 from "@angular/core";
export declare class NgxMaskPipe implements PipeTransform {
    private readonly defaultOptions;
    private readonly _maskService;
    private _maskExpressionArray;
    private mask;
    transform(value: string | number, mask: string, { patterns, ...config }?: Partial<IConfig>): string;
    private _setMask;
    static ɵfac: i0.ɵɵFactoryDeclaration<NgxMaskPipe, never>;
    static ɵpipe: i0.ɵɵPipeDeclaration<NgxMaskPipe, "mask", true>;
}
