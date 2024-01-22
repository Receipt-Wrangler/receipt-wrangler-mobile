import { SharedSelectorOptions } from '../internal/internals';
/**
 * Decorator for setting selector options at a method or class level.
 */
export declare function SelectorOptions(options: SharedSelectorOptions): ClassDecorator & MethodDecorator;
