import { StateClass } from '@ngxs/store/internals';
import { StoreOptions } from '../symbols';
/**
 * Decorates a class with ngxs state information.
 */
export declare function State<T>(options: StoreOptions<T>): (target: StateClass) => void;
