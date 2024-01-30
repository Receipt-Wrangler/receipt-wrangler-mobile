"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.toPattern = void 0;
function toPattern(value) {
    return RegExp(`^(${value.join('|')})$`);
}
exports.toPattern = toPattern;
