export interface PlainObject {
    [key: string]: any;
}
export interface PlainObjectOf<T> {
    [key: string]: T;
}
export declare type StateClass<T = any> = new (...args: any[]) => T;
