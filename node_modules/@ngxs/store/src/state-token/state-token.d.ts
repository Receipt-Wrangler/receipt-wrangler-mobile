import { TokenName } from './symbols';
export declare class StateToken<T = void> {
    private readonly name;
    constructor(name: TokenName<T>);
    getName(): string;
    toString(): string;
}
