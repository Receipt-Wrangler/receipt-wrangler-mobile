import { Type, ɵPipeDef } from '@angular/core';
export interface PipeType<T> extends Type<T> {
    ɵpipe: ɵPipeDef<T>;
}
export declare function isPipe<T>(target: any): target is PipeType<T>;
