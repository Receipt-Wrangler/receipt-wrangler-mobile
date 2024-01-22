"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getNodeToCommaRemoveFix = exports.getImplementsRemoveFix = exports.getDecoratorPropertyAddFix = exports.getImplementsSchemaFixer = exports.getImportRemoveFix = exports.getImportAddFix = void 0;
const utils_1 = require("@typescript-eslint/utils");
const ast_utils_1 = require("./ast-utils");
const utils_2 = require("../utils");
function getImportAddFix({ compatibleWithTypeOnlyImport = false, fixer, importName, moduleName, node, }) {
    const fullImport = `import { ${importName} } from '${moduleName}';\n`;
    const importDeclarations = (0, ast_utils_1.getImportDeclarations)(node, moduleName);
    if (!(importDeclarations === null || importDeclarations === void 0 ? void 0 : importDeclarations.length)) {
        return fixer.insertTextAfterRange([0, 0], fullImport);
    }
    const importDeclarationSpecifier = (0, ast_utils_1.getImportDeclarationSpecifier)(importDeclarations, importName);
    if (importDeclarationSpecifier) {
        return undefined;
    }
    const importClause = (0, ast_utils_1.getCorrespondentImportClause)(importDeclarations, compatibleWithTypeOnlyImport);
    if (!importClause) {
        return fixer.insertTextAfterRange([0, 0], fullImport);
    }
    const replacementText = (0, ast_utils_1.isImportDefaultSpecifier)(importClause)
        ? `, { ${importName} }`
        : `, ${importName}`;
    return fixer.insertTextAfter(importClause, replacementText);
}
exports.getImportAddFix = getImportAddFix;
function getImportRemoveFix(sourceCode, importDeclarations, importName, fixer) {
    var _a;
    const { importDeclaration, importSpecifier } = (_a = (0, ast_utils_1.getImportDeclarationSpecifier)(importDeclarations, importName)) !== null && _a !== void 0 ? _a : {};
    if (!importDeclaration || !importSpecifier)
        return undefined;
    const isFirstImportSpecifier = importDeclaration.specifiers[0] === importSpecifier;
    const isLastImportSpecifier = (0, utils_2.getLast)(importDeclaration.specifiers) === importSpecifier;
    const isSingleImportSpecifier = isFirstImportSpecifier && isLastImportSpecifier;
    if (isSingleImportSpecifier) {
        return fixer.remove(importDeclaration);
    }
    const tokenAfterImportSpecifier = sourceCode.getTokenAfter(importSpecifier);
    if (isFirstImportSpecifier && tokenAfterImportSpecifier) {
        return fixer.removeRange([
            importSpecifier.range[0],
            tokenAfterImportSpecifier.range[1],
        ]);
    }
    const tokenBeforeImportSpecifier = sourceCode.getTokenBefore(importSpecifier);
    if (!tokenBeforeImportSpecifier)
        return undefined;
    return fixer.removeRange([
        tokenBeforeImportSpecifier.range[0],
        importSpecifier.range[1],
    ]);
}
exports.getImportRemoveFix = getImportRemoveFix;
function getImplementsSchemaFixer({ id, implements: classImplements }, interfaceName) {
    const [implementsNodeReplace, implementsTextReplace] = classImplements
        ? [(0, utils_2.getLast)(classImplements), `, ${interfaceName}`]
        : [id, ` implements ${interfaceName}`];
    return { implementsNodeReplace, implementsTextReplace };
}
exports.getImplementsSchemaFixer = getImplementsSchemaFixer;
function getDecoratorPropertyAddFix({ expression }, fixer, text) {
    if (!(0, ast_utils_1.isCallExpression)(expression)) {
        return undefined;
    }
    const [firstArgument] = expression.arguments;
    if (!firstArgument || !(0, ast_utils_1.isObjectExpression)(firstArgument)) {
        // `@Component()` => `@Component({changeDetection: ChangeDetectionStrategy.OnPush})`
        const [initialRange, endRange] = expression.range;
        return fixer.insertTextAfterRange([initialRange + 1, endRange - 1], `{${text}}`);
    }
    const { properties } = firstArgument;
    if (properties.length === 0) {
        //` @Component({})` => `@Component({changeDetection: ChangeDetectionStrategy.OnPush})`
        const [initialRange, endRange] = firstArgument.range;
        return fixer.insertTextAfterRange([initialRange + 1, endRange - 1], text);
    }
    // `@Component({...})` => `@Component({changeDetection: ChangeDetectionStrategy.OnPush, ...})`
    return fixer.insertTextBefore(properties[0], `${text},`);
}
exports.getDecoratorPropertyAddFix = getDecoratorPropertyAddFix;
function getImplementsRemoveFix(sourceCode, classDeclaration, interfaceName, fixer) {
    const { implements: classImplements } = classDeclaration;
    if (!classImplements)
        return undefined;
    const identifier = (0, ast_utils_1.getInterface)(classDeclaration, interfaceName);
    if (!identifier)
        return undefined;
    const isFirstInterface = classImplements[0].expression === identifier;
    const isLastInterface = (0, utils_2.getLast)(classImplements).expression === identifier;
    const hasSingleInterfaceImplemented = isFirstInterface && isLastInterface;
    const tokenBeforeInterface = sourceCode.getTokenBefore(identifier);
    if (hasSingleInterfaceImplemented) {
        return !tokenBeforeInterface || !(0, ast_utils_1.isImplementsToken)(tokenBeforeInterface)
            ? undefined
            : fixer.removeRange([
                tokenBeforeInterface.range[0],
                classImplements[0].range[1],
            ]);
    }
    if (isFirstInterface) {
        const tokenAfterInterface = sourceCode.getTokenAfter(identifier);
        return !tokenAfterInterface
            ? undefined
            : fixer.removeRange([identifier.range[0], tokenAfterInterface.range[1]]);
    }
    return !tokenBeforeInterface
        ? undefined
        : fixer.removeRange([tokenBeforeInterface.range[0], identifier.range[1]]);
}
exports.getImplementsRemoveFix = getImplementsRemoveFix;
function getNodeToCommaRemoveFix(sourceCode, node, fixer) {
    const tokenAfterNode = sourceCode.getTokenAfter(node);
    return tokenAfterNode && utils_1.ASTUtils.isCommaToken(tokenAfterNode)
        ? fixer.removeRange([node.range[0], tokenAfterNode.range[1]])
        : fixer.remove(node);
}
exports.getNodeToCommaRemoveFix = getNodeToCommaRemoveFix;
