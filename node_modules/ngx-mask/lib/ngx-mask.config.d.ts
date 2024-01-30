import { EventEmitter, InjectionToken } from '@angular/core';
export interface InputTransformFn {
    (value: unknown): string | number;
}
export interface OutputTransformFn {
    (value: string | number | undefined | null): unknown;
}
export interface IConfig {
    suffix: string;
    prefix: string;
    thousandSeparator: string;
    decimalMarker: '.' | ',' | ['.', ','];
    clearIfNotMatch: boolean;
    showTemplate: boolean;
    showMaskTyped: boolean;
    placeHolderCharacter: string;
    shownMaskExpression: string;
    specialCharacters: string[] | readonly string[];
    dropSpecialCharacters: boolean | string[] | readonly string[];
    hiddenInput: boolean | undefined;
    validation: boolean;
    separatorLimit: string;
    apm: boolean;
    allowNegativeNumbers: boolean;
    leadZeroDateTime: boolean;
    leadZero: boolean;
    triggerOnMaskChange: boolean;
    keepCharacterPositions: boolean;
    inputTransformFn: InputTransformFn;
    outputTransformFn: OutputTransformFn;
    maskFilled: EventEmitter<void>;
    patterns: {
        [character: string]: {
            pattern: RegExp;
            optional?: boolean;
            symbol?: string;
        };
    };
}
export type optionsConfig = Partial<IConfig>;
export declare const NGX_MASK_CONFIG: InjectionToken<IConfig>;
export declare const NEW_CONFIG: InjectionToken<IConfig>;
export declare const INITIAL_CONFIG: InjectionToken<IConfig>;
export declare const initialConfig: IConfig;
export declare const timeMasks: string[];
export declare const withoutValidation: string[];
