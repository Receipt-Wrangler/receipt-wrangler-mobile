"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addIonicModuleImportToNgModule = void 0;
const schematics_1 = require("@angular-devkit/schematics");
const ast_utils_1 = require("@schematics/angular/utility/ast-utils");
const change_1 = require("@schematics/angular/utility/change");
const ts = require("typescript");
/**
 * Reads file given path and returns TypeScript source file.
 */
function getSourceFile(host, path) {
    const buffer = host.read(path);
    if (!buffer) {
        throw new schematics_1.SchematicsException(`Could not find file for path: ${path}`);
    }
    const content = buffer.toString();
    const source = ts.createSourceFile(path, content, ts.ScriptTarget.Latest, true);
    return source;
}
/**
 * Import and add module to root app module.
 */
function addIonicModuleImportToNgModule(host, modulePath) {
    const recorder = host.beginUpdate(modulePath);
    const moduleSource = getSourceFile(host, modulePath);
    const ionicModuleChange = (0, ast_utils_1.insertImport)(moduleSource, modulePath, 'IonicModule', '@ionic/angular');
    (0, change_1.applyToUpdateRecorder)(recorder, [ionicModuleChange]);
    const metadataChange = (0, ast_utils_1.addSymbolToNgModuleMetadata)(moduleSource, modulePath, 'imports', 'IonicModule.forRoot({})');
    (0, change_1.applyToUpdateRecorder)(recorder, metadataChange);
    host.commitUpdate(recorder);
}
exports.addIonicModuleImportToNgModule = addIonicModuleImportToNgModule;
