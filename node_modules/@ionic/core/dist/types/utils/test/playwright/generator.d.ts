export type Mode = 'ios' | 'md';
export type Direction = 'ltr' | 'rtl';
/**
 * The theme to use for the playwright test.
 *
 * - `light`: The fallback theme values. Theme stylesheet will not be included.
 * - `dark`: The dark theme values.
 */
export type Theme = 'light' | 'dark';
export type TitleFn = (title: string) => string;
export type ScreenshotFn = (fileName: string) => string;
export interface TestConfig {
    mode: Mode;
    direction: Direction;
    theme: Theme;
}
interface TestUtilities {
    title: TitleFn;
    screenshot: ScreenshotFn;
    config: TestConfig;
}
interface TestConfigOption {
    modes?: Mode[];
    directions?: Direction[];
    themes?: Theme[];
}
/**
 * Given a config generate an array of test variants.
 */
export declare const configs: (testConfig?: TestConfigOption) => TestUtilities[];
export {};
