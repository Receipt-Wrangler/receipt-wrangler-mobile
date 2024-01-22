/**
 * Decorator for selecting a slice of state from the store.
 */
export declare function Select<T>(rawSelector?: T, ...paths: string[]): PropertyDecorator;
