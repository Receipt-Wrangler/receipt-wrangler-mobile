import { Observable } from 'rxjs';
import { StateToken } from '../../state-token/state-token';
import { ExtractTokenType } from '../../state-token/symbols';
export declare function createSelectObservable<T = any>(selector: any): Observable<T>;
export declare function createSelectorFn(name: string, rawSelector?: any, paths?: string[]): any;
/**
 * @example If `foo$` => make it just `foo`
 */
export declare function removeDollarAtTheEnd(name: string): string;
export declare type PropertyType<T> = T extends StateToken<any> ? Observable<ExtractTokenType<T>> : T extends (...args: any[]) => any ? Observable<ReturnType<T>> : any;
