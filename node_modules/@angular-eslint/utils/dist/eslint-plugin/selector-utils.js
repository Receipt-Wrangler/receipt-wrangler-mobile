"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkSelector = exports.checkValidOptions = exports.reportTypeError = exports.reportStyleAndPrefixError = exports.reportStyleError = exports.reportPrefixError = exports.SelectorValidator = exports.OPTION_TYPE_ELEMENT = exports.OPTION_TYPE_ATTRS = exports.OPTION_TYPE_ATTRIBUTE = void 0;
const bundled_angular_compiler_1 = require("@angular-eslint/bundled-angular-compiler");
const ast_utils_1 = require("./ast-utils");
const utils_1 = require("../utils");
exports.OPTION_TYPE_ATTRIBUTE = 'attribute';
exports.OPTION_TYPE_ATTRS = 'attrs';
exports.OPTION_TYPE_ELEMENT = 'element';
const SELECTOR_TYPE_MAPPER = {
    [exports.OPTION_TYPE_ATTRIBUTE]: exports.OPTION_TYPE_ATTRS,
    [exports.OPTION_TYPE_ELEMENT]: exports.OPTION_TYPE_ELEMENT,
};
exports.SelectorValidator = {
    attribute(selector) {
        return selector.length !== 0;
    },
    camelCase(selector) {
        return /^[a-zA-Z0-9[\]]+$/.test(selector);
    },
    element(selector) {
        return selector !== null;
    },
    kebabCase(selector) {
        return /^[a-z0-9-]+-[a-z0-9-]+$/.test(selector);
    },
    prefix(prefix, selectorStyle) {
        const regex = new RegExp(`^\\[?(${prefix})`);
        return (selector) => {
            if (!prefix)
                return true;
            if (!regex.test(selector))
                return false;
            const suffix = selector.replace(regex, '');
            if (selectorStyle === ast_utils_1.OPTION_STYLE_CAMEL_CASE) {
                return !suffix || suffix[0] === suffix[0].toUpperCase();
            }
            else if (selectorStyle === ast_utils_1.OPTION_STYLE_KEBAB_CASE) {
                return !suffix || suffix[0] === '-';
            }
            throw Error('Invalid selector style!');
        };
    },
};
const getValidSelectors = (selectors, types) => {
    return selectors.reduce((previousValue, currentValue) => {
        const validSelectors = types.reduce((accumulator, type) => {
            const value = currentValue[type];
            return value ? accumulator.concat(value) : accumulator;
        }, []);
        return previousValue.concat(validSelectors);
    }, []);
};
const reportPrefixError = (node, prefix, context) => {
    context.report({
        node,
        messageId: 'prefixFailure',
        data: {
            prefix: (0, utils_1.toHumanReadableText)((0, utils_1.arrayify)(prefix)),
        },
    });
};
exports.reportPrefixError = reportPrefixError;
const reportStyleError = (node, style, context) => {
    context.report({
        node,
        messageId: 'styleFailure',
        data: {
            style,
        },
    });
};
exports.reportStyleError = reportStyleError;
const reportStyleAndPrefixError = (node, style, prefix, context) => {
    context.report({
        node,
        messageId: 'styleAndPrefixFailure',
        data: {
            style,
            prefix: (0, utils_1.toHumanReadableText)((0, utils_1.arrayify)(prefix)),
        },
    });
};
exports.reportStyleAndPrefixError = reportStyleAndPrefixError;
const reportTypeError = (node, type, context) => {
    context.report({
        node,
        messageId: 'typeFailure',
        data: {
            type,
        },
    });
};
exports.reportTypeError = reportTypeError;
const checkValidOptions = (type, prefix, style) => {
    // Get options
    const typeOption = (0, utils_1.arrayify)(type);
    const styleOption = style;
    // Check if options are valid
    const isTypeOptionValid = typeOption.length > 0 &&
        typeOption.every((argument) => [exports.OPTION_TYPE_ELEMENT, exports.OPTION_TYPE_ATTRIBUTE].indexOf(argument) !== -1);
    const isPrefixOptionValid = prefix.length > 0;
    const isStyleOptionValid = [ast_utils_1.OPTION_STYLE_CAMEL_CASE, ast_utils_1.OPTION_STYLE_KEBAB_CASE].indexOf(styleOption) !==
        -1;
    return isTypeOptionValid && isPrefixOptionValid && isStyleOptionValid;
};
exports.checkValidOptions = checkValidOptions;
const checkSelector = (node, typeOption, prefixOption, styleOption) => {
    // Get valid list of selectors
    const types = (0, utils_1.arrayify)(typeOption || [exports.OPTION_TYPE_ATTRS, exports.OPTION_TYPE_ELEMENT]).reduce((previousValue, currentValue) => previousValue.concat(SELECTOR_TYPE_MAPPER[currentValue]), []);
    const styleValidator = styleOption === ast_utils_1.OPTION_STYLE_KEBAB_CASE
        ? exports.SelectorValidator.kebabCase
        : exports.SelectorValidator.camelCase;
    let listSelectors = null;
    if (node && (0, ast_utils_1.isLiteral)(node)) {
        listSelectors = bundled_angular_compiler_1.CssSelector.parse(node.raw);
    }
    else if (node && (0, ast_utils_1.isTemplateLiteral)(node) && node.quasis[0]) {
        listSelectors = bundled_angular_compiler_1.CssSelector.parse(node.quasis[0].value.raw);
    }
    if (!listSelectors) {
        return null;
    }
    const validSelectors = getValidSelectors(listSelectors, types);
    const hasExpectedPrefix = validSelectors.some((selector) => prefixOption.some((prefix) => exports.SelectorValidator.prefix(prefix, styleOption)(selector)));
    const hasExpectedStyle = validSelectors.some((selector) => styleValidator(selector));
    const hasExpectedType = validSelectors.length > 0;
    return {
        hasExpectedPrefix,
        hasExpectedType,
        hasExpectedStyle,
    };
};
exports.checkSelector = checkSelector;
