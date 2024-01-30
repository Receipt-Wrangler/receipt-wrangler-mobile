/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
import { expect } from "@playwright/test";
import { configs, test } from "../../../../utils/test/playwright/index";
/**
 * This behavior does not vary across modes/directions
 */
configs({ modes: ['ios'], directions: ['ltr'] }).forEach(({ title, config }) => {
    test.describe(title('menu: disable'), () => {
        test.beforeEach(async ({ page }) => {
            await page.goto(`/src/components/menu/test/disable`, config);
        });
        test('should disable when menu is fully open', async ({ page }) => {
            const logs = [];
            page.on('console', (msg) => {
                if (msg.type() === 'error') {
                    logs.push(msg.text());
                }
            });
            const menu = page.locator('ion-menu');
            // Should be visible on initial presentation
            await menu.evaluate((el) => el.open());
            await expect(menu).toBeVisible();
            // Disabling menu should hide it
            await menu.evaluate((el) => (el.disabled = true));
            await expect(menu).toBeHidden();
            // Re-enabling menu and opening it show make it visible
            await menu.evaluate((el) => (el.disabled = false));
            await menu.evaluate((el) => el.open());
            await expect(menu).toBeVisible();
            expect(logs.length).toBe(0);
        });
        test('should disable when menu is animating', async ({ page }) => {
            const logs = [];
            page.on('console', (msg) => {
                if (msg.type() === 'error') {
                    logs.push(msg.text());
                }
            });
            const menu = page.locator('ion-menu');
            // Opening and quickly disabling menu should hide it
            menu.evaluate((el) => {
                el.open();
                setTimeout(() => (el.disabled = true), 0);
            });
            await expect(menu).toBeHidden();
            // Re-enabling menu and opening it show make it visible
            await menu.evaluate((el) => (el.disabled = false));
            await menu.evaluate((el) => el.open());
            await expect(menu).toBeVisible();
            expect(logs.length).toBe(0);
        });
    });
});
