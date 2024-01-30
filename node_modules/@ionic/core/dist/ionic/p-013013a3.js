/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
import{h as l}from"./p-23a9d086.js";const a=a=>{const r=a;let t;return{hasLegacyControl:()=>{if(void 0===t){const a=void 0!==r.label||o(r),O=r.hasAttribute("aria-label")||r.hasAttribute("aria-labelledby")&&null===r.shadowRoot,e=l(r);t=!0===r.legacy||!a&&!O&&null!==e}return t}}},o=l=>!(!r.includes(l.tagName)||null===l.querySelector('[slot="label"]'))||!(!t.includes(l.tagName)||""===l.textContent),r=["ION-INPUT","ION-TEXTAREA","ION-SELECT","ION-RANGE"],t=["ION-TOGGLE","ION-CHECKBOX","ION-RADIO"];export{a as c}