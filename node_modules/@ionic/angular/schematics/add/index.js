"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const core_1 = require("@angular-devkit/core");
const schematics_1 = require("@angular-devkit/schematics");
const tasks_1 = require("@angular-devkit/schematics/tasks");
const utility_1 = require("@schematics/angular/utility");
const workspace_1 = require("@schematics/angular/utility/workspace");
const ast_1 = require("../utils/ast");
const config_1 = require("./../utils/config");
const package_1 = require("./../utils/package");
function addIonicAngularToPackageJson() {
    return (host) => {
        (0, package_1.addPackageToPackageJson)(host, 'dependencies', '@ionic/angular', 'latest');
        return host;
    };
}
function addIonicAngularToolkitToPackageJson() {
    return (host) => {
        (0, package_1.addPackageToPackageJson)(host, 'devDependencies', '@ionic/angular-toolkit', 'latest');
        return host;
    };
}
/**
 * Adds the @ionic/angular-toolkit schematics and cli configuration to the project's `angular.json` file.
 * @param projectName The name of the project.
 */
function addIonicAngularToolkitToAngularJson() {
    return (host) => {
        (0, config_1.addCli)(host, '@ionic/angular-toolkit');
        (0, config_1.addSchematics)(host, '@ionic/angular-toolkit:component', {
            styleext: 'scss',
        });
        (0, config_1.addSchematics)(host, '@ionic/angular-toolkit:page', {
            styleext: 'scss',
        });
        return host;
    };
}
/**
 * Adds the `IonicModule.forRoot()` usage to the project's `AppModule`.
 * If the project does not use modules this will operate as a noop.
 * @param projectSourceRoot The source root path of the project.
 */
function addIonicAngularModuleToAppModule(projectSourceRoot) {
    return (host) => {
        const appModulePath = `${projectSourceRoot}/app/app.module.ts`;
        if (host.exists(appModulePath)) {
            (0, ast_1.addIonicModuleImportToNgModule)(host, appModulePath);
        }
        return host;
    };
}
/**
 * Adds the `provideIonicAngular` usage to the project's app config.
 * If the project does not use an app config this will operate as a noop.
 * @param projectName The name of the project.
 * @param projectSourceRoot The source root path of the project.
 */
function addProvideIonicAngular(projectName, projectSourceRoot) {
    return (host) => {
        const appConfig = `${projectSourceRoot}/app/app.config.ts`;
        if (host.exists(appConfig)) {
            return (0, utility_1.addRootProvider)(projectName, ({ code, external }) => code `${external('provideIonicAngular', '@ionic/angular/standalone')}({})`);
        }
        return host;
    };
}
function addIonicStyles(projectName, projectSourceRoot) {
    return (host) => {
        const ionicStyles = [
            'node_modules/@ionic/angular/css/core.css',
            'node_modules/@ionic/angular/css/normalize.css',
            'node_modules/@ionic/angular/css/structure.css',
            'node_modules/@ionic/angular/css/typography.css',
            'node_modules/@ionic/angular/css/display.css',
            'node_modules/@ionic/angular/css/padding.css',
            'node_modules/@ionic/angular/css/float-elements.css',
            'node_modules/@ionic/angular/css/text-alignment.css',
            'node_modules/@ionic/angular/css/text-transformation.css',
            'node_modules/@ionic/angular/css/flex-utils.css',
            `${projectSourceRoot}/theme/variables.css`,
        ];
        ionicStyles.forEach((entry) => {
            (0, config_1.addStyle)(host, projectName, entry);
        });
        return host;
    };
}
function addIonicons(projectName, projectSourceRoot) {
    return (host) => {
        const hasAppModule = host.exists(`${projectSourceRoot}/app/app.module.ts`);
        if (hasAppModule) {
            /**
             * Add Ionicons to the `angular.json` file only if the project
             * is using the lazy build of `@ionic/angular` with modules.
             */
            const ioniconsGlob = {
                glob: '**/*.svg',
                input: 'node_modules/ionicons/dist/ionicons/svg',
                output: './svg',
            };
            (0, config_1.addAsset)(host, projectName, 'build', ioniconsGlob);
            (0, config_1.addAsset)(host, projectName, 'test', ioniconsGlob);
        }
        return host;
    };
}
function addIonicConfig(projectSourceRoot) {
    return (host) => {
        const ionicConfig = 'ionic.config.json';
        if (!host.exists(ionicConfig)) {
            const hasAppModule = host.exists(`${projectSourceRoot}/app/app.module.ts`);
            const type = hasAppModule ? 'angular' : 'angular-standalone';
            host.create(ionicConfig, JSON.stringify({
                name: 'ionic-app',
                app_id: '',
                type,
                integrations: {},
            }, null, 2));
        }
        return host;
    };
}
function addIonicBuilder(projectName) {
    return (host) => {
        (0, config_1.addArchitectBuilder)(host, projectName, 'ionic-cordova-serve', {
            builder: '@ionic/angular-toolkit:cordova-serve',
            options: {
                cordovaBuildTarget: `${projectName}:ionic-cordova-build`,
                devServerTarget: `${projectName}:serve`,
            },
            configurations: {
                production: {
                    cordovaBuildTarget: `${projectName}:ionic-cordova-build:production`,
                    devServerTarget: `${projectName}:serve:production`,
                },
            },
        });
        (0, config_1.addArchitectBuilder)(host, projectName, 'ionic-cordova-build', {
            builder: '@ionic/angular-toolkit:cordova-build',
            options: {
                browserTarget: `${projectName}:build`,
            },
            configurations: {
                production: {
                    browserTarget: `${projectName}:build:production`,
                },
            },
        });
        return host;
    };
}
function installNodeDeps() {
    return (_host, context) => {
        context.addTask(new tasks_1.NodePackageInstallTask());
    };
}
function ngAdd(options) {
    return async (host) => {
        const workspace = await (0, workspace_1.getWorkspace)(host);
        if (!options.project) {
            options.project = (0, config_1.getDefaultAngularAppName)(workspace);
        }
        const project = workspace.projects.get(options.project);
        if (!project || project.extensions.projectType !== 'application') {
            throw new schematics_1.SchematicsException(`Ionic Add requires a project type of "application".`);
        }
        const sourcePath = (0, core_1.join)(project.sourceRoot);
        const rootTemplateSource = (0, schematics_1.apply)((0, schematics_1.url)('./files/root'), [(0, schematics_1.template)(Object.assign({}, options)), (0, schematics_1.move)(sourcePath)]);
        return (0, schematics_1.chain)([
            // @ionic/angular
            addIonicAngularToPackageJson(),
            addIonicAngularToolkitToPackageJson(),
            addIonicAngularToolkitToAngularJson(),
            addIonicAngularModuleToAppModule(sourcePath),
            addProvideIonicAngular(options.project, sourcePath),
            addIonicBuilder(options.project),
            addIonicStyles(options.project, sourcePath),
            addIonicons(options.project, sourcePath),
            addIonicConfig(sourcePath),
            (0, schematics_1.mergeWith)(rootTemplateSource),
            // install freshly added dependencies
            installNodeDeps(),
        ]);
    };
}
exports.default = ngAdd;
