/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
/**
 * Generates a unique test title based on a base title
 * and a test config. Playwright uses test titles to generate
 * test IDs for the test reports, so it's important that
 * each test title is unique.
 */
const generateTitle = (title, config) => {
    const { mode, direction, theme } = config;
    if (theme === 'light') {
        /**
         * Ionic has many existing tests that existed prior to
         * the introduction of theme testing. To maintain backwards
         * compatibility, we will not include the theme in the test
         * title if the theme is set to light.
         */
        return `${title} - ${mode}/${direction}`;
    }
    return `${title} - ${mode}/${direction}/${theme}`;
};
/**
 * Generates a unique filename based on a base filename
 * and a test config.
 */
const generateScreenshotName = (fileName, config) => {
    const { mode, direction, theme } = config;
    if (theme === 'light') {
        /**
         * Ionic has many existing tests that existed prior to
         * the introduction of theme testing. To maintain backwards
         * compatibility, we will not include the theme in the screenshot
         * name if the theme is set to light.
         */
        return `${fileName}-${mode}-${direction}.png`;
    }
    return `${fileName}-${mode}-${direction}-${theme}.png`;
};
/**
 * Given a config generate an array of test variants.
 */
export const configs = (testConfig = DEFAULT_TEST_CONFIG_OPTION) => {
    var _a;
    const { modes, directions } = testConfig;
    const configs = [];
    /**
     * If certain options are not provided,
     * fall back to the defaults.
     */
    const processedMode = modes !== null && modes !== void 0 ? modes : DEFAULT_MODES;
    const processedDirection = directions !== null && directions !== void 0 ? directions : DEFAULT_DIRECTIONS;
    const processedTheme = (_a = testConfig.themes) !== null && _a !== void 0 ? _a : DEFAULT_THEMES;
    processedMode.forEach((mode) => {
        processedDirection.forEach((direction) => {
            processedTheme.forEach((theme) => {
                configs.push({ mode, direction, theme });
            });
        });
    });
    return configs.map((config) => {
        return {
            config,
            title: (title) => generateTitle(title, config),
            screenshot: (fileName) => generateScreenshotName(fileName, config),
        };
    });
};
const DEFAULT_MODES = ['ios', 'md'];
const DEFAULT_DIRECTIONS = ['ltr', 'rtl'];
const DEFAULT_THEMES = ['light'];
const DEFAULT_TEST_CONFIG_OPTION = {
    modes: DEFAULT_MODES,
    directions: DEFAULT_DIRECTIONS,
};
