import { ElementRef } from '@angular/core';
import { IConfig } from './ngx-mask.config';
import { NgxMaskApplierService } from './ngx-mask-applier.service';
import * as i0 from "@angular/core";
export declare class NgxMaskService extends NgxMaskApplierService {
    isNumberValue: boolean;
    maskIsShown: string;
    selStart: number | null;
    selEnd: number | null;
    /**
     * Whether we are currently in writeValue function, in this case when applying the mask we don't want to trigger onChange function,
     * since writeValue should be a one way only process of writing the DOM value based on the Angular model value.
     */
    writingValue: boolean;
    maskChanged: boolean;
    _maskExpressionArray: string[];
    triggerOnMaskChange: boolean;
    _previousValue: string;
    _currentValue: string;
    private _emitValue;
    private _start;
    private _end;
    onChange: (_: any) => void;
    readonly _elementRef: ElementRef<any> | null;
    private readonly document;
    protected _config: IConfig;
    private readonly _renderer;
    applyMask(inputValue: string, maskExpression: string, position?: number, justPasted?: boolean, backspaced?: boolean, cb?: (...args: any[]) => any): string;
    private _numberSkipedSymbols;
    applyValueChanges(position: number, justPasted: boolean, backspaced: boolean, cb?: (...args: any[]) => any): void;
    hideInput(inputValue: string, maskExpression: string): string;
    getActualValue(res: string): string;
    shiftTypedSymbols(inputValue: string): string;
    /**
     * Convert number value to string
     * 3.1415 -> '3.1415'
     * 1e-7 -> '0.0000001'
     */
    numberToString(value: number | string): string;
    showMaskInInput(inputVal?: string): string;
    clearIfNotMatchFn(): void;
    set formElementProperty([name, value]: [string, string | boolean]);
    checkDropSpecialCharAmount(mask: string): number;
    removeMask(inputValue: string): string;
    private _checkForIp;
    private _checkForCpfCnpj;
    /**
     * Recursively determine the current active element by navigating the Shadow DOM until the Active Element is found.
     */
    private _getActiveElement;
    /**
     * Propogates the input value back to the Angular model by triggering the onChange function. It won't do this if writingValue
     * is true. If that is true it means we are currently in the writeValue function, which is supposed to only update the actual
     * DOM element based on the Angular model value. It should be a one way process, i.e. writeValue should not be modifying the Angular
     * model value too. Therefore, we don't trigger onChange in this scenario.
     * @param inputValue the current form input value
     */
    private formControlResult;
    private _toNumber;
    private _removeMask;
    private _removePrefix;
    private _removeSuffix;
    private _retrieveSeparatorValue;
    private _regExpForRemove;
    private _replaceDecimalMarkerToDot;
    _checkSymbols(result: string): string | number | undefined | null;
    private _checkPatternForSpace;
    private _retrieveSeparatorPrecision;
    _checkPrecision(separatorExpression: string, separatorValue: string): number | string;
    _repeatPatternSymbols(maskExp: string): string;
    currentLocaleDecimalMarker(): string;
    static ɵfac: i0.ɵɵFactoryDeclaration<NgxMaskService, never>;
    static ɵprov: i0.ɵɵInjectableDeclaration<NgxMaskService>;
}
