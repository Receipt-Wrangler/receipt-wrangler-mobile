/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
import { expect } from "@playwright/test";
/**
 * Warning: This function will fail when in RTL mode.
 * TODO(FW-3711): Remove the `directions` config when this issue preventing
 * tests from passing in RTL mode is resolved.
 */
export const testSlidingItem = async (page, itemID, screenshotNameSuffix, screenshot, openStart = false) => {
    const item = page.locator(`#${itemID}`);
    // passing a param into the eval callback is tricky due to execution context
    // so just do the check outside the callback instead to make things easy
    if (openStart) {
        await item.evaluate(async (el) => {
            await el.open('start');
        });
    }
    else {
        await item.evaluate(async (el) => {
            await el.open('end');
        });
    }
    // opening animation takes longer than waitForChanges accounts for
    // especially if another item sliding is already open,
    // so we wait to ensure the opened item is closed before
    // opening another
    await page.waitForTimeout(500);
    await expect(item).toHaveScreenshot(screenshot(`item-sliding-${screenshotNameSuffix}`));
    await item.evaluate(async (el) => {
        await el.close();
    });
};
