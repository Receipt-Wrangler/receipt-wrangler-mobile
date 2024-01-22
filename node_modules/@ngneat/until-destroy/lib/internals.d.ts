import { InjectableType, ɵDirectiveType, ɵComponentType } from '@angular/core';
import { PipeType } from './ivy';
/**
 * Applied to definitions and informs that class is decorated
 */
export declare const DECORATOR_APPLIED: unique symbol;
/**
 * If we use the `untilDestroyed` operator multiple times inside the single
 * instance providing different `destroyMethodName`, then all streams will
 * subscribe to the single subject. If any method is invoked, the subject will
 * emit and all streams will be unsubscribed. We wan't to prevent this behavior,
 * thus we store subjects under different symbols.
 */
export declare function getSymbol<T>(destroyMethodName?: keyof T): symbol;
export declare function markAsDecorated<T>(type: InjectableType<T> | PipeType<T> | ɵDirectiveType<T> | ɵComponentType<T>): void;
export interface UntilDestroyOptions {
    blackList?: string[];
    arrayName?: string;
    checkProperties?: boolean;
}
export declare function createSubjectOnTheInstance(instance: any, symbol: symbol): void;
export declare function completeSubjectOnTheInstance(instance: any, symbol: symbol): void;
