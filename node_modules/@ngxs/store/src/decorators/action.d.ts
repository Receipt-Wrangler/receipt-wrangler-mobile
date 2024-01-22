import { ActionType, ActionOptions } from '../actions/symbols';
/**
 * Decorates a method with a action information.
 */
export declare function Action(actions: ActionType | ActionType[], options?: ActionOptions): MethodDecorator;
