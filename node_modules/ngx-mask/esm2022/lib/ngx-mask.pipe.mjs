import { inject, Pipe } from '@angular/core';
import { NgxMaskService } from './ngx-mask.service';
import * as i0 from "@angular/core";
export class NgxMaskPipe {
    constructor() {
        this.defaultOptions = {};
        this._maskService = inject(NgxMaskService);
        this._maskExpressionArray = [];
        this.mask = '';
    }
    transform(value, mask, { patterns, ...config } = {}) {
        const currentConfig = {
            maskExpression: mask,
            ...this.defaultOptions,
            ...config,
            patterns: {
                ...this._maskService.patterns,
                ...patterns,
            },
        };
        Object.entries(currentConfig).forEach(([key, value]) => {
            //eslint-disable-next-line  @typescript-eslint/no-explicit-any
            this._maskService[key] = value;
        });
        if (mask.includes('||')) {
            if (mask.split('||').length > 1) {
                this._maskExpressionArray = mask.split('||').sort((a, b) => {
                    return a.length - b.length;
                });
                this._setMask(value);
                return this._maskService.applyMask(`${value}`, this.mask);
            }
            else {
                this._maskExpressionArray = [];
                return this._maskService.applyMask(`${value}`, this.mask);
            }
        }
        if (mask.includes("{" /* MaskExpression.CURLY_BRACKETS_LEFT */)) {
            return this._maskService.applyMask(`${value}`, this._maskService._repeatPatternSymbols(mask));
        }
        if (mask.startsWith("separator" /* MaskExpression.SEPARATOR */)) {
            if (config.decimalMarker) {
                this._maskService.decimalMarker = config.decimalMarker;
            }
            if (config.thousandSeparator) {
                this._maskService.thousandSeparator = config.thousandSeparator;
            }
            if (config.leadZero) {
                // eslint-disable-next-line no-param-reassign
                this._maskService.leadZero = config.leadZero;
            }
            // eslint-disable-next-line no-param-reassign
            value = String(value);
            const localeDecimalMarker = this._maskService.currentLocaleDecimalMarker();
            if (!Array.isArray(this._maskService.decimalMarker)) {
                // eslint-disable-next-line no-param-reassign
                value =
                    this._maskService.decimalMarker !== localeDecimalMarker
                        ? value.replace(localeDecimalMarker, this._maskService.decimalMarker)
                        : value;
            }
            if (this._maskService.leadZero &&
                value &&
                this._maskService.dropSpecialCharacters !== false) {
                // eslint-disable-next-line no-param-reassign
                value = this._maskService._checkPrecision(mask, value);
            }
            if (this._maskService.decimalMarker === "," /* MaskExpression.COMMA */) {
                // eslint-disable-next-line no-param-reassign
                value = value.toString().replace("." /* MaskExpression.DOT */, "," /* MaskExpression.COMMA */);
            }
            this._maskService.isNumberValue = true;
        }
        if (value === null || value === undefined) {
            return this._maskService.applyMask('', mask);
        }
        return this._maskService.applyMask(`${value}`, mask);
    }
    _setMask(value) {
        if (this._maskExpressionArray.length > 0) {
            this._maskExpressionArray.some((mask) => {
                const test = this._maskService.removeMask(value)?.length <=
                    this._maskService.removeMask(mask)?.length;
                if (value && test) {
                    this.mask = mask;
                    return test;
                }
                else {
                    const expression = this._maskExpressionArray[this._maskExpressionArray.length - 1] ??
                        "" /* MaskExpression.EMPTY_STRING */;
                    this.mask = expression;
                }
            });
        }
    }
    static { this.ɵfac = i0.ɵɵngDeclareFactory({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskPipe, deps: [], target: i0.ɵɵFactoryTarget.Pipe }); }
    static { this.ɵpipe = i0.ɵɵngDeclarePipe({ minVersion: "14.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskPipe, isStandalone: true, name: "mask" }); }
}
i0.ɵɵngDeclareClassMetadata({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskPipe, decorators: [{
            type: Pipe,
            args: [{
                    name: 'mask',
                    pure: true,
                    standalone: true,
                }]
        }] });
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibmd4LW1hc2sucGlwZS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL3Byb2plY3RzL25neC1tYXNrLWxpYi9zcmMvbGliL25neC1tYXNrLnBpcGUudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsT0FBTyxFQUFFLE1BQU0sRUFBRSxJQUFJLEVBQWlCLE1BQU0sZUFBZSxDQUFDO0FBRzVELE9BQU8sRUFBRSxjQUFjLEVBQUUsTUFBTSxvQkFBb0IsQ0FBQzs7QUFRcEQsTUFBTSxPQUFPLFdBQVc7SUFMeEI7UUFNcUIsbUJBQWMsR0FBcUIsRUFBRSxDQUFDO1FBRXRDLGlCQUFZLEdBQUcsTUFBTSxDQUFDLGNBQWMsQ0FBQyxDQUFDO1FBRS9DLHlCQUFvQixHQUFhLEVBQUUsQ0FBQztRQUVwQyxTQUFJLEdBQUcsRUFBRSxDQUFDO0tBaUdyQjtJQS9GVSxTQUFTLENBQ1osS0FBc0IsRUFDdEIsSUFBWSxFQUNaLEVBQUUsUUFBUSxFQUFFLEdBQUcsTUFBTSxLQUF1QixFQUFzQjtRQUVsRSxNQUFNLGFBQWEsR0FBRztZQUNsQixjQUFjLEVBQUUsSUFBSTtZQUNwQixHQUFHLElBQUksQ0FBQyxjQUFjO1lBQ3RCLEdBQUcsTUFBTTtZQUNULFFBQVEsRUFBRTtnQkFDTixHQUFHLElBQUksQ0FBQyxZQUFZLENBQUMsUUFBUTtnQkFDN0IsR0FBRyxRQUFRO2FBQ2Q7U0FDSixDQUFDO1FBQ0YsTUFBTSxDQUFDLE9BQU8sQ0FBQyxhQUFhLENBQUMsQ0FBQyxPQUFPLENBQUMsQ0FBQyxDQUFDLEdBQUcsRUFBRSxLQUFLLENBQUMsRUFBRSxFQUFFO1lBQ25ELDhEQUE4RDtZQUM3RCxJQUFJLENBQUMsWUFBb0IsQ0FBQyxHQUFHLENBQUMsR0FBRyxLQUFLLENBQUM7UUFDNUMsQ0FBQyxDQUFDLENBQUM7UUFDSCxJQUFJLElBQUksQ0FBQyxRQUFRLENBQUMsSUFBSSxDQUFDLEVBQUU7WUFDckIsSUFBSSxJQUFJLENBQUMsS0FBSyxDQUFDLElB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LEVBQUUsRUFBRSxJQUFJLENBQUMsQ0FBQztTQUNoRDtRQUNELE9BQU8sSUFBSSxDQUFDLFlBQVksQ0FBQyxTQUFTLENBQUMsR0FBRyxLQUFLLEVBQUUsRUFBRSxJQUFJLENBQUMsQ0FBQztJQUN6RCxDQUFDO0lBRU8sUUFBUSxDQUFDLEtBQWE7UUFDMUIsSUFBSSxJQUFJLENBQUMsb0JBQW9CLENBQUMsTUFBTSxHQUFHLENBQUMsRUFBRTtZQUN0QyxJQUFJLENBQUMsb0JBQW9CLENBQUMsSUFBSSxDQUFDLENBQUMsSUFBSSxFQUFrQixFQUFFO2dCQUNwRCxNQUFNLElBQUksR0FDTixJQUFJLENBQUMsWUFBWSxDQUFDLFVBQVUsQ0FBQyxLQUFLLENBQUMsRUFBRSxNQUFNO29CQUMzQyxJQUFJLENBQUMsWUFBWSxDQUFDLFVBQVUsQ0FBQyxJQUFJLENBQUMsRUFBRSxNQUFNLENBQUM7Z0JBQy9DLElBQUksS0FBSyxJQUFJLElBQUksRUFBRTtvQkFDZixJQUFJLENBQUMsSUFBSSxHQUFHLElBQUksQ0FBQztvQkFDakIsT0FBTyxJQUFJLENBQUM7aUJBQ2Y7cUJBQU07b0JBQ0gsTUFBTSxVQUFVLEdBQ1osSUFBSSxDQUFDLG9CQUFvQixDQUFDLElBQUksQ0FBQyxvQkFBb0IsQ0FBQyxNQUFNLEdBQUcsQ0FBQyxDQUFDOzREQUNwQyxDQUFDO29CQUNoQyxJQUFJLENBQUMsSUFBSSxHQUFHLFVBQVUsQ0FBQztpQkFDMUI7WUFDTCxDQUFDLENBQUMsQ0FBQztTQUNOO0lBQ0wsQ0FBQzsrR0F2R1EsV0FBVzs2R0FBWCxXQUFXOzs0RkFBWCxXQUFXO2tCQUx2QixJQUFJO21CQUFDO29CQUNGLElBQUksRUFBRSxNQUFNO29CQUNaLElBQUksRUFBRSxJQUFJO29CQUNWLFVBQVUsRUFBRSxJQUFJO2lCQUNuQiIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7IGluamVjdCwgUGlwZSwgUGlwZVRyYW5zZm9ybSB9IGZyb20gJ0Bhbmd1bGFyL2NvcmUnO1xuXG5pbXBvcnQgeyBJQ29uZmlnIH0gZnJvbSAnLi9uZ3gtbWFzay5jb25maWcnO1xuaW1wb3J0IHsgTmd4TWFza1NlcnZpY2UgfSBmcm9tICcuL25neC1tYXNrLnNlcnZpY2UnO1xuaW1wb3J0IHsgTWFza0V4cHJlc3Npb24gfSBmcm9tICcuL25neC1tYXNrLWV4cHJlc3Npb24uZW51bSc7XG5cbkBQaXBlKHtcbiAgICBuYW1lOiAnbWFzaycsXG4gICAgcHVyZTogdHJ1ZSxcbiAgICBzdGFuZGFsb25lOiB0cnVlLFxufSlcbmV4cG9ydCBjbGFzcyBOZ3hNYXNrUGlwZSBpbXBsZW1lbnRzIFBpcGVUcmFuc2Zvcm0ge1xuICAgIHByaXZhdGUgcmVhZG9ubHkgZGVmYXVsdE9wdGlvbnM6IFBhcnRpYWw8SUNvbmZpZz4gPSB7fTtcblxuICAgIHByaXZhdGUgcmVhZG9ubHkgX21hc2tTZXJ2aWNlID0gaW5qZWN0KE5neE1hc2tTZXJ2aWNlKTtcblxuICAgIHByaXZhdGUgX21hc2tFeHByZXNzaW9uQXJyYXk6IHN0cmluZ1tdID0gW107XG5cbiAgICBwcml2YXRlIG1hc2sgPSAnJztcblxuICAgIHB1YmxpYyB0cmFuc2Zvcm0oXG4gICAgICAgIHZhbHVlOiBzdHJpbmcgfCBudW1iZXIsXG4gICAgICAgIG1hc2s6IHN0cmluZyxcbiAgICAgICAgeyBwYXR0ZXJucywgLi4uY29uZmlnIH06IFBhcnRpYWw8SUNvbmZpZz4gPSB7fSBhcyBQYXJ0aWFsPElDb25maWc+XG4gICAgKTogc3RyaW5nIHtcbiAgICAgICAgY29uc3QgY3VycmVudENvbmZpZyA9IHtcbiAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uOiBtYXNrLFxuICAgICAgICAgICAgLi4udGhpcy5kZWZhdWx0T3B0aW9ucyxcbiAgICAgICAgICAgIC4uLmNvbmZpZyxcbiAgICAgICAgICAgIHBhdHRlcm5zOiB7XG4gICAgICAgICAgICAgICAgLi4udGhpcy5fbWFza1NlcnZpY2UucGF0dGVybnMsXG4gICAgICAgICAgICAgICAgLi4ucGF0dGVybnMsXG4gICAgICAgICAgICB9LFxuICAgICAgICB9O1xuICAgICAgICBPYmplY3QuZW50cmllcyhjdXJyZW50Q29uZmlnKS5mb3JFYWNoKChba2V5LCB2YWx1ZV0pID0+IHtcbiAgICAgICAgICAgIC8vZXNsaW50LWRpc2FibGUtbmV4dC1saW5lICBAdHlwZXNjcmlwdC1lc2xpbnQvbm8tZXhwbGljaXQtYW55XG4gICAgICAgICAgICAodGhpcy5fbWFza1NlcnZpY2UgYXMgYW55KVtrZXldID0gdmFsdWU7XG4gICAgICAgIH0pO1xuICAgICAgICBpZiAobWFzay5pbmNsdWRlcygnfHwnKSkge1xuICAgICAgICAgICAgaWYgKG1hc2suc3BsaXQoJ3x8JykubGVuZ3RoID4gMSkge1xuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tFeHByZXNzaW9uQXJyYXkgPSBtYXNrLnNwbGl0KCd8fCcpLnNvcnQoKGE6IHN0cmluZywgYjogc3RyaW5nKSA9PiB7XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiBhLmxlbmd0aCAtIGIubGVuZ3RoO1xuICAgICAgICAgICAgICAgIH0pO1xuICAgICAgICAgICAgICAgIHRoaXMuX3NldE1hc2sodmFsdWUgYXMgc3RyaW5nKTtcbiAgICAgICAgICAgICAgICByZXR1cm4gdGhpcy5fbWFza1NlcnZpY2UuYXBwbHlNYXNrKGAke3ZhbHVlfWAsIHRoaXMubWFzayk7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tFeHByZXNzaW9uQXJyYXkgPSBbXTtcbiAgICAgICAgICAgICAgICByZXR1cm4gdGhpcy5fbWFza1NlcnZpY2UuYXBwbHlNYXNrKGAke3ZhbHVlfWAsIHRoaXMubWFzayk7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cbiAgICAgICAgaWYgKG1hc2suaW5jbHVkZXMoTWFza0V4cHJlc3Npb24uQ1VSTFlfQlJBQ0tFVFNfTEVGVCkpIHtcbiAgICAgICAgICAgIHJldHVybiB0aGlzLl9tYXNrU2VydmljZS5hcHBseU1hc2soXG4gICAgICAgICAgICAgICAgYCR7dmFsdWV9YCxcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5fcmVwZWF0UGF0dGVyblN5bWJvbHMobWFzaylcbiAgICAgICAgICAgICk7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKG1hc2suc3RhcnRzV2l0aChNYXNrRXhwcmVzc2lvbi5TRVBBUkFUT1IpKSB7XG4gICAgICAgICAgICBpZiAoY29uZmlnLmRlY2ltYWxNYXJrZXIpIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5kZWNpbWFsTWFya2VyID0gY29uZmlnLmRlY2ltYWxNYXJrZXI7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoY29uZmlnLnRob3VzYW5kU2VwYXJhdG9yKSB7XG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UudGhvdXNhbmRTZXBhcmF0b3IgPSBjb25maWcudGhvdXNhbmRTZXBhcmF0b3I7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoY29uZmlnLmxlYWRaZXJvKSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubGVhZFplcm8gPSBjb25maWcubGVhZFplcm87XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgIHZhbHVlID0gU3RyaW5nKHZhbHVlKTtcbiAgICAgICAgICAgIGNvbnN0IGxvY2FsZURlY2ltYWxNYXJrZXIgPSB0aGlzLl9tYXNrU2VydmljZS5jdXJyZW50TG9jYWxlRGVjaW1hbE1hcmtlcigpO1xuICAgICAgICAgICAgaWYgKCFBcnJheS5pc0FycmF5KHRoaXMuX21hc2tTZXJ2aWNlLmRlY2ltYWxNYXJrZXIpKSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgdmFsdWUgPVxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5kZWNpbWFsTWFya2VyICE9PSBsb2NhbGVEZWNpbWFsTWFya2VyXG4gICAgICAgICAgICAgICAgICAgICAgICA/IHZhbHVlLnJlcGxhY2UobG9jYWxlRGVjaW1hbE1hcmtlciwgdGhpcy5fbWFza1NlcnZpY2UuZGVjaW1hbE1hcmtlcilcbiAgICAgICAgICAgICAgICAgICAgICAgIDogdmFsdWU7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubGVhZFplcm8gJiZcbiAgICAgICAgICAgICAgICB2YWx1ZSAmJlxuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmRyb3BTcGVjaWFsQ2hhcmFjdGVycyAhPT0gZmFsc2VcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIHZhbHVlID0gdGhpcy5fbWFza1NlcnZpY2UuX2NoZWNrUHJlY2lzaW9uKG1hc2ssIHZhbHVlIGFzIHN0cmluZyk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAodGhpcy5fbWFza1NlcnZpY2UuZGVjaW1hbE1hcmtlciA9PT0gTWFza0V4cHJlc3Npb24uQ09NTUEpIHtcbiAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICB2YWx1ZSA9IHZhbHVlLnRvU3RyaW5nKCkucmVwbGFjZShNYXNrRXhwcmVzc2lvbi5ET1QsIE1hc2tFeHByZXNzaW9uLkNPTU1BKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmlzTnVtYmVyVmFsdWUgPSB0cnVlO1xuICAgICAgICB9XG4gICAgICAgIGlmICh2YWx1ZSA9PT0gbnVsbCB8fCB2YWx1ZSA9PT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5fbWFza1NlcnZpY2UuYXBwbHlNYXNrKCcnLCBtYXNrKTtcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gdGhpcy5fbWFza1NlcnZpY2UuYXBwbHlNYXNrKGAke3ZhbHVlfWAsIG1hc2spO1xuICAgIH1cblxuICAgIHByaXZhdGUgX3NldE1hc2sodmFsdWU6IHN0cmluZykge1xuICAgICAgICBpZiAodGhpcy5fbWFza0V4cHJlc3Npb25BcnJheS5sZW5ndGggPiAwKSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrRXhwcmVzc2lvbkFycmF5LnNvbWUoKG1hc2spOiBib29sZWFuIHwgdm9pZCA9PiB7XG4gICAgICAgICAgICAgICAgY29uc3QgdGVzdCA9XG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnJlbW92ZU1hc2sodmFsdWUpPy5sZW5ndGggPD1cbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UucmVtb3ZlTWFzayhtYXNrKT8ubGVuZ3RoO1xuICAgICAgICAgICAgICAgIGlmICh2YWx1ZSAmJiB0ZXN0KSB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMubWFzayA9IG1hc2s7XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiB0ZXN0O1xuICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGV4cHJlc3Npb24gPVxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza0V4cHJlc3Npb25BcnJheVt0aGlzLl9tYXNrRXhwcmVzc2lvbkFycmF5Lmxlbmd0aCAtIDFdID8/XG4gICAgICAgICAgICAgICAgICAgICAgICBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkc7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMubWFzayA9IGV4cHJlc3Npb247XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfSk7XG4gICAgICAgIH1cbiAgICB9XG59XG4iXX0=