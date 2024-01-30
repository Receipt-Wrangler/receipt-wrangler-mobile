"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const schematics_1 = require("@angular-devkit/schematics");
const tasks_1 = require("@angular-devkit/schematics/tasks");
const utils_1 = require("../../utils");
const dependencies_1 = require("../utils/dependencies");
const updatedTypeScriptESLintVersion = '5.36.2';
const updatedESLintVersion = '8.23.0';
function migration() {
    return (0, schematics_1.chain)([
        (0, dependencies_1.updateDependencies)([
            {
                packageName: '@typescript-eslint/eslint-plugin',
                version: `^${updatedTypeScriptESLintVersion}`,
            },
            {
                packageName: '@typescript-eslint/experimental-utils',
                version: `^${updatedTypeScriptESLintVersion}`,
            },
            {
                packageName: '@typescript-eslint/parser',
                version: `^${updatedTypeScriptESLintVersion}`,
            },
            {
                packageName: 'eslint',
                version: `^${updatedESLintVersion}`,
            },
        ]),
        (0, utils_1.updateJsonInTree)('angular.json', (json) => {
            var _a;
            // Migrate any workspaces which use the original defaultCollection (but only if set to `@angular-eslint/schematics`)
            if (((_a = json.cli) === null || _a === void 0 ? void 0 : _a.defaultCollection) !== '@angular-eslint/schematics') {
                return json;
            }
            return (0, utils_1.updateSchematicCollections)(json);
        }),
        // Migrate from @typescript-eslint/experimental-utils package name to @typescript-eslint/utils
        (host, context) => (0, utils_1.updateJsonInTree)('package.json', (json) => {
            var _a;
            const devDep = (_a = json.devDependencies) === null || _a === void 0 ? void 0 : _a['@typescript-eslint/experimental-utils'];
            if (!devDep) {
                return json;
            }
            json.devDependencies['@typescript-eslint/utils'] = devDep;
            delete json.devDependencies['@typescript-eslint/experimental-utils'];
            json.devDependencies = (0, utils_1.sortObjectByKeys)(json.devDependencies);
            host.overwrite('package.json', JSON.stringify(json, null, 2));
            context.addTask(new tasks_1.NodePackageInstallTask());
            return json;
        }),
    ]);
}
exports.default = migration;
