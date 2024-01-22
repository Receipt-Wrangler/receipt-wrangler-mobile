import { Observable } from 'rxjs';
export declare function untilDestroyed<T>(instance: T, destroyMethodName?: keyof T): <U>(source: Observable<U>) => Observable<U>;
