import { StateToken } from './state-token';
declare type RequireGeneric<T, U> = T extends void ? 'You must provide a type parameter' : U;
export declare type TokenName<T> = string & RequireGeneric<T, string>;
export declare type ExtractTokenType<P> = P extends StateToken<infer T> ? T : never;
export {};
