/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
import { h, setMode } from "@stencil/core";
import { newSpecPage } from "@stencil/core/testing";
import { Content } from "../../../content/content";
import { Modal } from "../../modal";
describe('modal: canDismiss', () => {
    describe('modal: regular modal', () => {
        it('should dismiss when canDismiss is true', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => h("ion-modal", { overlayIndex: 1, animated: false, canDismiss: true }),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(true);
        });
        it('should not dismiss when canDismiss is false', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => h("ion-modal", { overlayIndex: 1, animated: false, canDismiss: false }),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(false);
        });
        it('should dismiss when canDismiss is Promise<true>', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, animated: false, canDismiss: () => {
                        return new Promise((resolve) => {
                            setTimeout(() => resolve(true), 50);
                        });
                    } })),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(true);
        });
        it('should not dismiss when canDismiss is Promise<false>', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, animated: false, canDismiss: () => {
                        return new Promise((resolve) => {
                            setTimeout(() => resolve(false), 50);
                        });
                    } })),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(false);
        });
    });
    describe('modal: card modal', () => {
        beforeEach(() => {
            /**
             * Card modal is only available on iOS
             */
            setMode(() => 'ios');
        });
        it('should dismiss when canDismiss is true', async () => {
            const page = await newSpecPage({
                components: [Content, Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, presentingElement: document.createElement('div'), animated: false, canDismiss: true }, h("ion-content", null, "Test Content"))),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(true);
        });
        it('should not dismiss when canDismiss is false', async () => {
            const page = await newSpecPage({
                components: [Content, Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, presentingElement: document.createElement('div'), animated: false, canDismiss: false }, h("ion-content", null, "Test Content"))),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(false);
        });
        it('should dismiss when canDismiss is Promise<true>', async () => {
            const page = await newSpecPage({
                components: [Content, Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, presentingElement: document.createElement('div'), animated: false, canDismiss: () => {
                        return new Promise((resolve) => {
                            setTimeout(() => resolve(true), 50);
                        });
                    } }, h("ion-content", null, "Test Content"))),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(true);
        });
        it('should not dismiss when canDismiss is Promise<false>', async () => {
            const page = await newSpecPage({
                components: [Content, Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, presentingElement: document.createElement('div'), animated: false, canDismiss: () => {
                        return new Promise((resolve) => {
                            setTimeout(() => resolve(false), 50);
                        });
                    } }, h("ion-content", null, "Test Content"))),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(false);
        });
    });
    describe('modal: sheet modal', () => {
        it('should dismiss when canDismiss is true', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, breakpoints: [0, 1], initialBreakpoint: 1, animated: false, canDismiss: true })),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(true);
        });
        it('should not dismiss when canDismiss is false', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, breakpoints: [0, 1], initialBreakpoint: 1, animated: false, canDismiss: false })),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(false);
        });
        it('should dismiss when canDismiss is Promise<true>', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, breakpoints: [0, 1], initialBreakpoint: 1, animated: false, canDismiss: () => {
                        return new Promise((resolve) => {
                            setTimeout(() => resolve(true), 50);
                        });
                    } })),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(true);
        });
        it('should not dismiss when canDismiss is Promise<false>', async () => {
            const page = await newSpecPage({
                components: [Modal],
                template: () => (h("ion-modal", { overlayIndex: 1, breakpoints: [0, 1], initialBreakpoint: 1, animated: false, canDismiss: () => {
                        return new Promise((resolve) => {
                            setTimeout(() => resolve(false), 50);
                        });
                    } })),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            const returnValue = await modal.dismiss();
            await expect(returnValue).toBe(false);
        });
    });
    describe('modal: data and role', () => {
        test('should pass data and role when calling dismiss', async () => {
            const canDismiss = jest.fn();
            const page = await newSpecPage({
                components: [Modal],
                template: () => h("ion-modal", { overlayIndex: 1, animated: false, canDismiss: canDismiss }),
            });
            const modal = page.body.querySelector('ion-modal');
            await modal.present();
            await page.waitForChanges();
            await modal.dismiss('my data', 'my role');
            expect(canDismiss).toHaveBeenCalledWith('my data', 'my role');
        });
    });
});
