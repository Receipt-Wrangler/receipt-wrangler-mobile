"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isPresentationRole = void 0;
const get_attribute_value_1 = require("./get-attribute-value");
const presentationRoles = new Set([
    'none',
    'presentation',
]);
function isPresentationRole(node) {
    const roleAttributeValue = (0, get_attribute_value_1.getAttributeValue)(node, 'role');
    return (typeof roleAttributeValue === 'string' &&
        presentationRoles.has(roleAttributeValue));
}
exports.isPresentationRole = isPresentationRole;
