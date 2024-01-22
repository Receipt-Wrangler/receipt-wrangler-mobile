declare function defaultEqualityCheck(a: any, b: any): boolean;
/**
 * Memoize a function on its last inputs only.
 * Originally from: https://github.com/reduxjs/reselect/blob/master/src/index.js
 *
 * @ignore
 */
export declare function memoize<T extends (...args: any[]) => any>(func: T, equalityCheck?: typeof defaultEqualityCheck): T;
export {};
