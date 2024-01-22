/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
import { h } from "@stencil/core";
import { newSpecPage } from "@stencil/core/testing";
import { Datetime } from "../../../datetime/datetime";
import { PickerColumnInternal } from "../../../picker-column-internal/picker-column-internal";
import { PickerInternal } from "../../../picker-internal/picker-internal";
describe('ion-datetime disabled', () => {
    beforeEach(() => {
        // IntersectionObserver isn't available in test environment
        const mockIntersectionObserver = jest.fn();
        mockIntersectionObserver.mockReturnValue({
            observe: () => null,
            unobserve: () => null,
            disconnect: () => null,
        });
        global.IntersectionObserver = mockIntersectionObserver;
    });
    it('picker should be disabled in prefer wheel mode', async () => {
        const page = await newSpecPage({
            components: [Datetime, PickerColumnInternal, PickerInternal],
            template: () => (h("ion-datetime", { id: "inline-datetime-wheel", disabled: true, "prefer-wheel": true, value: "2022-04-21T00:00:00" })),
        });
        await page.waitForChanges();
        const datetime = page.body.querySelector('ion-datetime');
        const columns = datetime.shadowRoot.querySelectorAll('ion-picker-column-internal');
        await expect(columns.length).toEqual(4);
        columns.forEach((column) => {
            expect(column.disabled).toBe(true);
        });
    });
});
