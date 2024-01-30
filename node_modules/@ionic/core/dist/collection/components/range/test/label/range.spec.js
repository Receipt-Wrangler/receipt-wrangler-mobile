/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
import { newSpecPage } from "@stencil/core/testing";
import { Range } from "../../range";
describe('range: label', () => {
    it('should prioritize the label prop over the slot', async () => {
        var _a, _b;
        const page = await newSpecPage({
            components: [Range],
            html: `
        <ion-range label="Label prop">
          <div slot="label">Label slot</div>
        </ion-range>
      `,
        });
        const range = page.body.querySelector('ion-range');
        const propEl = (_a = range === null || range === void 0 ? void 0 : range.shadowRoot) === null || _a === void 0 ? void 0 : _a.querySelector('.label-text');
        const slotEl = (_b = range === null || range === void 0 ? void 0 : range.shadowRoot) === null || _b === void 0 ? void 0 : _b.querySelector('slot[name="label"]');
        expect(propEl).not.toBeNull();
        expect(slotEl).toBeNull();
    });
});
