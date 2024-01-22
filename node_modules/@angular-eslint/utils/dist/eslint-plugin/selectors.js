"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.OUTPUT_PROPERTY_OR_GETTER = exports.OUTPUT_ALIAS = exports.OUTPUTS_METADATA_PROPERTY_LITERAL = exports.INPUT_PROPERTY_OR_SETTER = exports.INPUT_ALIAS = exports.INPUTS_METADATA_PROPERTY_LITERAL = exports.COMPONENT_OR_DIRECTIVE_SELECTOR_LITERAL = exports.DIRECTIVE_SELECTOR_LITERAL = exports.COMPONENT_SELECTOR_LITERAL = exports.methodDefinition = exports.metadataProperty = exports.LITERAL_OR_TEMPLATE_ELEMENT = exports.OUTPUT_DECORATOR = exports.INPUT_DECORATOR = exports.MODULE_CLASS_DECORATOR = exports.INJECTABLE_CLASS_DECORATOR = exports.PIPE_CLASS_DECORATOR = exports.DIRECTIVE_CLASS_DECORATOR = exports.COMPONENT_CLASS_DECORATOR = exports.COMPONENT_OR_DIRECTIVE_CLASS_DECORATOR = void 0;
exports.COMPONENT_OR_DIRECTIVE_CLASS_DECORATOR = 'ClassDeclaration > Decorator[expression.callee.name=/^(Component|Directive)$/]';
exports.COMPONENT_CLASS_DECORATOR = 'ClassDeclaration > Decorator[expression.callee.name="Component"]';
exports.DIRECTIVE_CLASS_DECORATOR = 'ClassDeclaration > Decorator[expression.callee.name="Directive"]';
exports.PIPE_CLASS_DECORATOR = 'ClassDeclaration > Decorator[expression.callee.name="Pipe"]';
exports.INJECTABLE_CLASS_DECORATOR = 'ClassDeclaration > Decorator[expression.callee.name="Injectable"]';
exports.MODULE_CLASS_DECORATOR = 'ClassDeclaration > Decorator[expression.callee.name="NgModule"]';
exports.INPUT_DECORATOR = 'Decorator[expression.callee.name="Input"]';
exports.OUTPUT_DECORATOR = 'Decorator[expression.callee.name="Output"]';
exports.LITERAL_OR_TEMPLATE_ELEMENT = ':matches(Literal, TemplateElement)';
function metadataProperty(key) {
    return `Property:matches([key.name=${key}][computed=false], [key.value=${key}], [key.quasis.0.value.raw=${key}])`;
}
exports.metadataProperty = metadataProperty;
function methodDefinition(key) {
    return `MethodDefinition:matches([key.name=${key}][computed=false], [key.value=${key}], [key.quasis.0.value.raw=${key}])`;
}
exports.methodDefinition = methodDefinition;
exports.COMPONENT_SELECTOR_LITERAL = `${exports.COMPONENT_CLASS_DECORATOR} ${metadataProperty('selector')} ${exports.LITERAL_OR_TEMPLATE_ELEMENT}`;
exports.DIRECTIVE_SELECTOR_LITERAL = `${exports.DIRECTIVE_CLASS_DECORATOR} ${metadataProperty('selector')} ${exports.LITERAL_OR_TEMPLATE_ELEMENT}`;
exports.COMPONENT_OR_DIRECTIVE_SELECTOR_LITERAL = `:matches(${exports.COMPONENT_SELECTOR_LITERAL}, ${exports.DIRECTIVE_SELECTOR_LITERAL})`;
exports.INPUTS_METADATA_PROPERTY_LITERAL = `${exports.COMPONENT_OR_DIRECTIVE_CLASS_DECORATOR} ${metadataProperty('inputs')} > ArrayExpression ${exports.LITERAL_OR_TEMPLATE_ELEMENT}`;
exports.INPUT_ALIAS = `:matches(PropertyDefinition, MethodDefinition[kind='set']) ${exports.INPUT_DECORATOR} ${exports.LITERAL_OR_TEMPLATE_ELEMENT}`;
exports.INPUT_PROPERTY_OR_SETTER = `:matches(PropertyDefinition, MethodDefinition[kind='set'])[computed=false]:has(${exports.INPUT_DECORATOR}) > :matches(Identifier, Literal)`;
exports.OUTPUTS_METADATA_PROPERTY_LITERAL = `${exports.COMPONENT_OR_DIRECTIVE_CLASS_DECORATOR} ${metadataProperty('outputs')} > ArrayExpression ${exports.LITERAL_OR_TEMPLATE_ELEMENT}`;
exports.OUTPUT_ALIAS = `:matches(PropertyDefinition, MethodDefinition[kind='get']) ${exports.OUTPUT_DECORATOR} ${exports.LITERAL_OR_TEMPLATE_ELEMENT}`;
exports.OUTPUT_PROPERTY_OR_GETTER = `:matches(PropertyDefinition, MethodDefinition[kind='get'])[computed=false]:has(${exports.OUTPUT_DECORATOR}) > :matches(Identifier, Literal)`;
