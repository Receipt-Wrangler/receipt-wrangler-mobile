import { DOCUMENT } from '@angular/common';
import { Directive, EventEmitter, HostListener, Input, Output, inject, } from '@angular/core';
import { NG_VALIDATORS, NG_VALUE_ACCESSOR, } from '@angular/forms';
import { NGX_MASK_CONFIG, timeMasks, withoutValidation } from './ngx-mask.config';
import { NgxMaskService } from './ngx-mask.service';
import * as i0 from "@angular/core";
export class NgxMaskDirective {
    constructor() {
        // eslint-disable-next-line @angular-eslint/no-input-rename
        this.maskExpression = '';
        this.specialCharacters = [];
        this.patterns = {};
        this.prefix = '';
        this.suffix = '';
        this.thousandSeparator = ' ';
        this.decimalMarker = '.';
        this.dropSpecialCharacters = null;
        this.hiddenInput = null;
        this.showMaskTyped = null;
        this.placeHolderCharacter = null;
        this.shownMaskExpression = null;
        this.showTemplate = null;
        this.clearIfNotMatch = null;
        this.validation = null;
        this.separatorLimit = null;
        this.allowNegativeNumbers = null;
        this.leadZeroDateTime = null;
        this.leadZero = null;
        this.triggerOnMaskChange = null;
        this.apm = null;
        this.inputTransformFn = null;
        this.outputTransformFn = null;
        this.keepCharacterPositions = null;
        this.maskFilled = new EventEmitter();
        this._maskValue = '';
        this._position = null;
        this._maskExpressionArray = [];
        this._justPasted = false;
        this._isFocused = false;
        /**For IME composition event */
        this._isComposing = false;
        this.document = inject(DOCUMENT);
        this._maskService = inject(NgxMaskService, { self: true });
        this._config = inject(NGX_MASK_CONFIG);
        // eslint-disable-next-line @typescript-eslint/no-empty-function, @typescript-eslint/no-explicit-any
        this.onChange = (_) => { };
        // eslint-disable-next-line @typescript-eslint/no-empty-function
        this.onTouch = () => { };
    }
    ngOnChanges(changes) {
        const { maskExpression, specialCharacters, patterns, prefix, suffix, thousandSeparator, decimalMarker, dropSpecialCharacters, hiddenInput, showMaskTyped, placeHolderCharacter, shownMaskExpression, showTemplate, clearIfNotMatch, validation, separatorLimit, allowNegativeNumbers, leadZeroDateTime, leadZero, triggerOnMaskChange, apm, inputTransformFn, outputTransformFn, keepCharacterPositions, } = changes;
        if (maskExpression) {
            if (maskExpression.currentValue !== maskExpression.previousValue &&
                !maskExpression.firstChange) {
                this._maskService.maskChanged = true;
            }
            if (maskExpression.currentValue &&
                maskExpression.currentValue.split("||" /* MaskExpression.OR */).length > 1) {
                this._maskExpressionArray = maskExpression.currentValue
                    .split("||" /* MaskExpression.OR */)
                    .sort((a, b) => {
                    return a.length - b.length;
                });
                this._setMask();
            }
            else {
                this._maskExpressionArray = [];
                this._maskValue = maskExpression.currentValue || "" /* MaskExpression.EMPTY_STRING */;
                this._maskService.maskExpression = this._maskValue;
            }
        }
        if (specialCharacters) {
            if (!specialCharacters.currentValue || !Array.isArray(specialCharacters.currentValue)) {
                return;
            }
            else {
                this._maskService.specialCharacters = specialCharacters.currentValue || [];
            }
        }
        if (allowNegativeNumbers) {
            this._maskService.allowNegativeNumbers = allowNegativeNumbers.currentValue;
            if (this._maskService.allowNegativeNumbers) {
                this._maskService.specialCharacters = this._maskService.specialCharacters.filter((c) => c !== "-" /* MaskExpression.MINUS */);
            }
        }
        // Only overwrite the mask available patterns if a pattern has actually been passed in
        if (patterns && patterns.currentValue) {
            this._maskService.patterns = patterns.currentValue;
        }
        if (apm && apm.currentValue) {
            this._maskService.apm = apm.currentValue;
        }
        if (prefix) {
            this._maskService.prefix = prefix.currentValue;
        }
        if (suffix) {
            this._maskService.suffix = suffix.currentValue;
        }
        if (thousandSeparator) {
            this._maskService.thousandSeparator = thousandSeparator.currentValue;
        }
        if (decimalMarker) {
            this._maskService.decimalMarker = decimalMarker.currentValue;
        }
        if (dropSpecialCharacters) {
            this._maskService.dropSpecialCharacters = dropSpecialCharacters.currentValue;
        }
        if (hiddenInput) {
            this._maskService.hiddenInput = hiddenInput.currentValue;
        }
        if (showMaskTyped) {
            this._maskService.showMaskTyped = showMaskTyped.currentValue;
            if (showMaskTyped.previousValue === false &&
                showMaskTyped.currentValue === true &&
                this._isFocused) {
                requestAnimationFrame(() => {
                    this._maskService._elementRef?.nativeElement.click();
                });
            }
        }
        if (placeHolderCharacter) {
            this._maskService.placeHolderCharacter = placeHolderCharacter.currentValue;
        }
        if (shownMaskExpression) {
            this._maskService.shownMaskExpression = shownMaskExpression.currentValue;
        }
        if (showTemplate) {
            this._maskService.showTemplate = showTemplate.currentValue;
        }
        if (clearIfNotMatch) {
            this._maskService.clearIfNotMatch = clearIfNotMatch.currentValue;
        }
        if (validation) {
            this._maskService.validation = validation.currentValue;
        }
        if (separatorLimit) {
            this._maskService.separatorLimit = separatorLimit.currentValue;
        }
        if (leadZeroDateTime) {
            this._maskService.leadZeroDateTime = leadZeroDateTime.currentValue;
        }
        if (leadZero) {
            this._maskService.leadZero = leadZero.currentValue;
        }
        if (triggerOnMaskChange) {
            this._maskService.triggerOnMaskChange = triggerOnMaskChange.currentValue;
        }
        if (inputTransformFn) {
            this._maskService.inputTransformFn = inputTransformFn.currentValue;
        }
        if (outputTransformFn) {
            this._maskService.outputTransformFn = outputTransformFn.currentValue;
        }
        if (keepCharacterPositions) {
            this._maskService.keepCharacterPositions = keepCharacterPositions.currentValue;
        }
        this._applyMask();
    }
    // eslint-disable-next-line complexity
    validate({ value }) {
        if (!this._maskService.validation || !this._maskValue) {
            return null;
        }
        if (this._maskService.ipError) {
            return this._createValidationError(value);
        }
        if (this._maskService.cpfCnpjError) {
            return this._createValidationError(value);
        }
        if (this._maskValue.startsWith("separator" /* MaskExpression.SEPARATOR */)) {
            return null;
        }
        if (withoutValidation.includes(this._maskValue)) {
            return null;
        }
        if (this._maskService.clearIfNotMatch) {
            return null;
        }
        if (timeMasks.includes(this._maskValue)) {
            return this._validateTime(value);
        }
        if (value && value.toString().length >= 1) {
            let counterOfOpt = 0;
            if (this._maskValue.startsWith("percent" /* MaskExpression.PERCENT */)) {
                return null;
            }
            for (const key in this._maskService.patterns) {
                if (this._maskService.patterns[key]?.optional) {
                    if (this._maskValue.indexOf(key) !== this._maskValue.lastIndexOf(key)) {
                        const opt = this._maskValue
                            .split("" /* MaskExpression.EMPTY_STRING */)
                            .filter((i) => i === key)
                            .join("" /* MaskExpression.EMPTY_STRING */);
                        counterOfOpt += opt.length;
                    }
                    else if (this._maskValue.indexOf(key) !== -1) {
                        counterOfOpt++;
                    }
                    if (this._maskValue.indexOf(key) !== -1 &&
                        value.toString().length >= this._maskValue.indexOf(key)) {
                        return null;
                    }
                    if (counterOfOpt === this._maskValue.length) {
                        return null;
                    }
                }
            }
            if (this._maskValue.indexOf("{" /* MaskExpression.CURLY_BRACKETS_LEFT */) === 1 &&
                value.toString().length ===
                    this._maskValue.length +
                        Number((this._maskValue.split("{" /* MaskExpression.CURLY_BRACKETS_LEFT */)[1] ??
                            "" /* MaskExpression.EMPTY_STRING */).split("}" /* MaskExpression.CURLY_BRACKETS_RIGHT */)[0]) -
                        4) {
                return null;
            }
            else if ((this._maskValue.indexOf("*" /* MaskExpression.SYMBOL_STAR */) > 1 &&
                value.toString().length <
                    this._maskValue.indexOf("*" /* MaskExpression.SYMBOL_STAR */)) ||
                (this._maskValue.indexOf("?" /* MaskExpression.SYMBOL_QUESTION */) > 1 &&
                    value.toString().length <
                        this._maskValue.indexOf("?" /* MaskExpression.SYMBOL_QUESTION */)) ||
                this._maskValue.indexOf("{" /* MaskExpression.CURLY_BRACKETS_LEFT */) === 1) {
                return this._createValidationError(value);
            }
            if (this._maskValue.indexOf("*" /* MaskExpression.SYMBOL_STAR */) === -1 ||
                this._maskValue.indexOf("?" /* MaskExpression.SYMBOL_QUESTION */) === -1) {
                // eslint-disable-next-line no-param-reassign
                value = typeof value === 'number' ? String(value) : value;
                const array = this._maskValue.split('*');
                const length = this._maskService.dropSpecialCharacters
                    ? this._maskValue.length -
                        this._maskService.checkDropSpecialCharAmount(this._maskValue) -
                        counterOfOpt
                    : this.prefix
                        ? this._maskValue.length + this.prefix.length - counterOfOpt
                        : this._maskValue.length - counterOfOpt;
                if (array.length === 1) {
                    if (value.toString().length < length) {
                        return this._createValidationError(value);
                    }
                }
                if (array.length > 1) {
                    const lastIndexArray = array[array.length - 1];
                    if (lastIndexArray &&
                        this._maskService.specialCharacters.includes(lastIndexArray[0]) &&
                        String(value).includes(lastIndexArray[0] ?? '') &&
                        !this.dropSpecialCharacters) {
                        const special = value.split(lastIndexArray[0]);
                        return special[special.length - 1].length === lastIndexArray.length - 1
                            ? null
                            : this._createValidationError(value);
                    }
                    else if (((lastIndexArray &&
                        !this._maskService.specialCharacters.includes(lastIndexArray[0])) ||
                        !lastIndexArray ||
                        this._maskService.dropSpecialCharacters) &&
                        value.length >= length - 1) {
                        return null;
                    }
                    else {
                        return this._createValidationError(value);
                    }
                }
            }
            if (this._maskValue.indexOf("*" /* MaskExpression.SYMBOL_STAR */) === 1 ||
                this._maskValue.indexOf("?" /* MaskExpression.SYMBOL_QUESTION */) === 1) {
                return null;
            }
        }
        if (value) {
            this.maskFilled.emit();
            return null;
        }
        return null;
    }
    onPaste() {
        this._justPasted = true;
    }
    onFocus() {
        this._isFocused = true;
    }
    onModelChange(value) {
        // on form reset we need to update the actualValue
        if ((value === "" /* MaskExpression.EMPTY_STRING */ || value === null || value === undefined) &&
            this._maskService.actualValue) {
            this._maskService.actualValue = this._maskService.getActualValue("" /* MaskExpression.EMPTY_STRING */);
        }
    }
    onInput(e) {
        // If IME is composing text, we wait for the composed text.
        if (this._isComposing)
            return;
        const el = e.target;
        const transformedValue = this._maskService.inputTransformFn(el.value);
        if (el.type !== 'number') {
            if (typeof transformedValue === 'string' || typeof transformedValue === 'number') {
                el.value = transformedValue.toString();
                this._inputValue = el.value;
                this._setMask();
                if (!this._maskValue) {
                    this.onChange(el.value);
                    return;
                }
                let position = el.selectionStart === 1
                    ? el.selectionStart + this._maskService.prefix.length
                    : el.selectionStart;
                if (this.showMaskTyped &&
                    this.keepCharacterPositions &&
                    this._maskService.placeHolderCharacter.length === 1) {
                    const inputSymbol = el.value.slice(position - 1, position);
                    const prefixLength = this.prefix.length;
                    const checkSymbols = this._maskService._checkSymbolMask(inputSymbol, this._maskService.maskExpression[position - 1 - prefixLength] ??
                        "" /* MaskExpression.EMPTY_STRING */);
                    const checkSpecialCharacter = this._maskService._checkSymbolMask(inputSymbol, this._maskService.maskExpression[position + 1 - prefixLength] ??
                        "" /* MaskExpression.EMPTY_STRING */);
                    const selectRangeBackspace = this._maskService.selStart === this._maskService.selEnd;
                    const selStart = Number(this._maskService.selStart) - prefixLength ?? '';
                    const selEnd = Number(this._maskService.selEnd) - prefixLength ?? '';
                    if (this._code === "Backspace" /* MaskExpression.BACKSPACE */) {
                        if (!selectRangeBackspace) {
                            if (this._maskService.selStart === prefixLength) {
                                this._maskService.actualValue =
                                    this.prefix +
                                        this._maskService.maskIsShown.slice(0, selEnd) +
                                        this._inputValue.split(this.prefix).join('');
                            }
                            else if (this._maskService.selStart ===
                                this._maskService.maskIsShown.length + prefixLength) {
                                this._maskService.actualValue =
                                    this._inputValue +
                                        this._maskService.maskIsShown.slice(selStart, selEnd);
                            }
                            else {
                                this._maskService.actualValue =
                                    this.prefix +
                                        this._inputValue
                                            .split(this.prefix)
                                            .join('')
                                            .slice(0, selStart) +
                                        this._maskService.maskIsShown.slice(selStart, selEnd) +
                                        this._maskService.actualValue.slice(selEnd + prefixLength, this._maskService.maskIsShown.length + prefixLength) +
                                        this.suffix;
                            }
                        }
                        else if (!this._maskService.specialCharacters.includes(this._maskService.maskExpression.slice(position - this.prefix.length, position + 1 - this.prefix.length)) &&
                            selectRangeBackspace) {
                            if (selStart === 1 && this.prefix) {
                                this._maskService.actualValue =
                                    this.prefix +
                                        this._maskService.placeHolderCharacter +
                                        el.value
                                            .split(this.prefix)
                                            .join('')
                                            .split(this.suffix)
                                            .join('') +
                                        this.suffix;
                                position = position - 1;
                            }
                            else {
                                const part1 = el.value.substring(0, position);
                                const part2 = el.value.substring(position);
                                this._maskService.actualValue =
                                    part1 + this._maskService.placeHolderCharacter + part2;
                            }
                        }
                    }
                    if (this._code !== "Backspace" /* MaskExpression.BACKSPACE */) {
                        if (!checkSymbols && !checkSpecialCharacter && selectRangeBackspace) {
                            position = Number(el.selectionStart) - 1;
                        }
                        else if (this._maskService.specialCharacters.includes(el.value.slice(position, position + 1)) &&
                            checkSpecialCharacter &&
                            !this._maskService.specialCharacters.includes(el.value.slice(position + 1, position + 2))) {
                            this._maskService.actualValue =
                                el.value.slice(0, position - 1) +
                                    el.value.slice(position, position + 1) +
                                    inputSymbol +
                                    el.value.slice(position + 2);
                            position = position + 1;
                        }
                        else if (checkSymbols) {
                            if (el.value.length === 1 && position === 1) {
                                this._maskService.actualValue =
                                    this.prefix +
                                        inputSymbol +
                                        this._maskService.maskIsShown.slice(1, this._maskService.maskIsShown.length) +
                                        this.suffix;
                            }
                            else {
                                this._maskService.actualValue =
                                    el.value.slice(0, position - 1) +
                                        inputSymbol +
                                        el.value
                                            .slice(position + 1)
                                            .split(this.suffix)
                                            .join('') +
                                        this.suffix;
                            }
                        }
                        else if (this.prefix &&
                            el.value.length === 1 &&
                            position - prefixLength === 1 &&
                            this._maskService._checkSymbolMask(el.value, this._maskService.maskExpression[position - 1 - prefixLength] ??
                                "" /* MaskExpression.EMPTY_STRING */)) {
                            this._maskService.actualValue =
                                this.prefix +
                                    el.value +
                                    this._maskService.maskIsShown.slice(1, this._maskService.maskIsShown.length) +
                                    this.suffix;
                        }
                    }
                }
                let caretShift = 0;
                let backspaceShift = false;
                if (this._code === "Delete" /* MaskExpression.DELETE */ && "separator" /* MaskExpression.SEPARATOR */) {
                    this._maskService.deletedSpecialCharacter = true;
                }
                if (this._inputValue.length >= this._maskService.maskExpression.length - 1 &&
                    this._code !== "Backspace" /* MaskExpression.BACKSPACE */ &&
                    this._maskService.maskExpression === "d0/M0/0000" /* MaskExpression.DAYS_MONTHS_YEARS */ &&
                    position < 10) {
                    const inputSymbol = this._inputValue.slice(position - 1, position);
                    el.value =
                        this._inputValue.slice(0, position - 1) +
                            inputSymbol +
                            this._inputValue.slice(position + 1);
                }
                if (this._maskService.maskExpression === "d0/M0/0000" /* MaskExpression.DAYS_MONTHS_YEARS */ &&
                    this.leadZeroDateTime) {
                    if ((position < 3 && Number(el.value) > 31 && Number(el.value) < 40) ||
                        (position === 5 && Number(el.value.slice(3, 5)) > 12)) {
                        position = position + 2;
                    }
                }
                if (this._maskService.maskExpression === "Hh:m0:s0" /* MaskExpression.HOURS_MINUTES_SECONDS */ &&
                    this.apm) {
                    if (this._justPasted && el.value.slice(0, 2) === "00" /* MaskExpression.DOUBLE_ZERO */) {
                        el.value = el.value.slice(1, 2) + el.value.slice(2, el.value.length);
                    }
                    el.value =
                        el.value === "00" /* MaskExpression.DOUBLE_ZERO */
                            ? "0" /* MaskExpression.NUMBER_ZERO */
                            : el.value;
                }
                this._maskService.applyValueChanges(position, this._justPasted, this._code === "Backspace" /* MaskExpression.BACKSPACE */ || this._code === "Delete" /* MaskExpression.DELETE */, (shift, _backspaceShift) => {
                    this._justPasted = false;
                    caretShift = shift;
                    backspaceShift = _backspaceShift;
                });
                // only set the selection if the element is active
                if (this._getActiveElement() !== el) {
                    return;
                }
                if (this._maskService.plusOnePosition) {
                    position = position + 1;
                    this._maskService.plusOnePosition = false;
                }
                // update position after applyValueChanges to prevent cursor on wrong position when it has an array of maskExpression
                if (this._maskExpressionArray.length) {
                    if (this._code === "Backspace" /* MaskExpression.BACKSPACE */) {
                        position = this.specialCharacters.includes(this._inputValue.slice(position - 1, position))
                            ? position - 1
                            : position;
                    }
                    else {
                        position =
                            el.selectionStart === 1
                                ? el.selectionStart + this._maskService.prefix.length
                                : el.selectionStart;
                    }
                }
                this._position =
                    this._position === 1 && this._inputValue.length === 1 ? null : this._position;
                let positionToApply = this._position
                    ? this._inputValue.length + position + caretShift
                    : position +
                        (this._code === "Backspace" /* MaskExpression.BACKSPACE */ && !backspaceShift ? 0 : caretShift);
                if (positionToApply > this._getActualInputLength()) {
                    positionToApply =
                        el.value === this._maskService.decimalMarker && el.value.length === 1
                            ? this._getActualInputLength() + 1
                            : this._getActualInputLength();
                }
                if (positionToApply < 0) {
                    positionToApply = 0;
                }
                el.setSelectionRange(positionToApply, positionToApply);
                this._position = null;
            }
            else {
                console.warn('Ngx-mask writeValue work with string | number, your current value:', typeof transformedValue);
            }
        }
        else {
            if (!this._maskValue) {
                this.onChange(el.value);
                return;
            }
            this._maskService.applyValueChanges(el.value.length, this._justPasted, this._code === "Backspace" /* MaskExpression.BACKSPACE */ || this._code === "Delete" /* MaskExpression.DELETE */);
        }
    }
    // IME starts
    onCompositionStart() {
        this._isComposing = true;
    }
    // IME completes
    onCompositionEnd(e) {
        this._isComposing = false;
        this._justPasted = true;
        this.onInput(e);
    }
    onBlur(e) {
        if (this._maskValue) {
            const el = e.target;
            if (this.leadZero && el.value.length > 0 && typeof this.decimalMarker === 'string') {
                const maskExpression = this._maskService.maskExpression;
                const precision = Number(this._maskService.maskExpression.slice(maskExpression.length - 1, maskExpression.length));
                if (precision > 1) {
                    el.value = this.suffix ? el.value.split(this.suffix).join('') : el.value;
                    const decimalPart = el.value.split(this.decimalMarker)[1];
                    el.value = el.value.includes(this.decimalMarker)
                        ? el.value +
                            "0" /* MaskExpression.NUMBER_ZERO */.repeat(precision - decimalPart.length) +
                            this.suffix
                        : el.value +
                            this.decimalMarker +
                            "0" /* MaskExpression.NUMBER_ZERO */.repeat(precision) +
                            this.suffix;
                    this._maskService.actualValue = el.value;
                }
            }
            this._maskService.clearIfNotMatchFn();
        }
        this._isFocused = false;
        this.onTouch();
    }
    onClick(e) {
        if (!this._maskValue) {
            return;
        }
        const el = e.target;
        const posStart = 0;
        const posEnd = 0;
        if (el !== null &&
            el.selectionStart !== null &&
            el.selectionStart === el.selectionEnd &&
            el.selectionStart > this._maskService.prefix.length &&
            // eslint-disable-next-line
            e.keyCode !== 38) {
            if (this._maskService.showMaskTyped && !this.keepCharacterPositions) {
                // We are showing the mask in the input
                this._maskService.maskIsShown = this._maskService.showMaskInInput();
                if (el.setSelectionRange &&
                    this._maskService.prefix + this._maskService.maskIsShown === el.value) {
                    // the input ONLY contains the mask, so position the cursor at the start
                    el.focus();
                    el.setSelectionRange(posStart, posEnd);
                }
                else {
                    // the input contains some characters already
                    if (el.selectionStart > this._maskService.actualValue.length) {
                        // if the user clicked beyond our value's length, position the cursor at the end of our value
                        el.setSelectionRange(this._maskService.actualValue.length, this._maskService.actualValue.length);
                    }
                }
            }
        }
        const nextValue = el &&
            (el.value === this._maskService.prefix
                ? this._maskService.prefix + this._maskService.maskIsShown
                : el.value);
        /** Fix of cursor position jumping to end in most browsers no matter where cursor is inserted onFocus */
        if (el && el.value !== nextValue) {
            el.value = nextValue;
        }
        /** fix of cursor position with prefix when mouse click occur */
        if (el &&
            el.type !== 'number' &&
            (el.selectionStart || el.selectionEnd) <=
                this._maskService.prefix.length) {
            el.selectionStart = this._maskService.prefix.length;
            return;
        }
        /** select only inserted text */
        if (el && el.selectionEnd > this._getActualInputLength()) {
            el.selectionEnd = this._getActualInputLength();
        }
    }
    // eslint-disable-next-line complexity
    onKeyDown(e) {
        if (!this._maskValue) {
            return;
        }
        if (this._isComposing) {
            // User finalize their choice from IME composition, so trigger onInput() for the composed text.
            if (e.key === 'Enter')
                this.onCompositionEnd(e);
            return;
        }
        this._code = e.code ? e.code : e.key;
        const el = e.target;
        this._inputValue = el.value;
        this._setMask();
        if (el.type !== 'number') {
            if (e.key === "ArrowUp" /* MaskExpression.ARROW_UP */) {
                e.preventDefault();
            }
            if (e.key === "ArrowLeft" /* MaskExpression.ARROW_LEFT */ ||
                e.key === "Backspace" /* MaskExpression.BACKSPACE */ ||
                e.key === "Delete" /* MaskExpression.DELETE */) {
                if (e.key === "Backspace" /* MaskExpression.BACKSPACE */ && el.value.length === 0) {
                    el.selectionStart = el.selectionEnd;
                }
                if (e.key === "Backspace" /* MaskExpression.BACKSPACE */ && el.selectionStart !== 0) {
                    // If specialChars is false, (shouldn't ever happen) then set to the defaults
                    this.specialCharacters = this.specialCharacters?.length
                        ? this.specialCharacters
                        : this._config.specialCharacters;
                    if (this.prefix.length > 1 &&
                        el.selectionStart <= this.prefix.length) {
                        el.setSelectionRange(this.prefix.length, el.selectionEnd);
                    }
                    else {
                        if (this._inputValue.length !== el.selectionStart &&
                            el.selectionStart !== 1) {
                            while (this.specialCharacters.includes((this._inputValue[el.selectionStart - 1] ??
                                "" /* MaskExpression.EMPTY_STRING */).toString()) &&
                                ((this.prefix.length >= 1 &&
                                    el.selectionStart > this.prefix.length) ||
                                    this.prefix.length === 0)) {
                                el.setSelectionRange(el.selectionStart - 1, el.selectionEnd);
                            }
                        }
                    }
                }
                this.checkSelectionOnDeletion(el);
                if (this._maskService.prefix.length &&
                    el.selectionStart <= this._maskService.prefix.length &&
                    el.selectionEnd <= this._maskService.prefix.length) {
                    e.preventDefault();
                }
                const cursorStart = el.selectionStart;
                if (e.key === "Backspace" /* MaskExpression.BACKSPACE */ &&
                    !el.readOnly &&
                    cursorStart === 0 &&
                    el.selectionEnd === el.value.length &&
                    el.value.length !== 0) {
                    this._position = this._maskService.prefix ? this._maskService.prefix.length : 0;
                    this._maskService.applyMask(this._maskService.prefix, this._maskService.maskExpression, this._position);
                }
            }
            if (!!this.suffix &&
                this.suffix.length > 1 &&
                this._inputValue.length - this.suffix.length < el.selectionStart) {
                el.setSelectionRange(this._inputValue.length - this.suffix.length, this._inputValue.length);
            }
            else if ((e.code === 'KeyA' && e.ctrlKey) ||
                (e.code === 'KeyA' && e.metaKey) // Cmd + A (Mac)
            ) {
                el.setSelectionRange(0, this._getActualInputLength());
                e.preventDefault();
            }
            this._maskService.selStart = el.selectionStart;
            this._maskService.selEnd = el.selectionEnd;
        }
    }
    /** It writes the value in the input */
    async writeValue(controlValue) {
        if (typeof controlValue === 'object' && controlValue !== null && 'value' in controlValue) {
            if ('disable' in controlValue) {
                this.setDisabledState(Boolean(controlValue.disable));
            }
            // eslint-disable-next-line no-param-reassign
            controlValue = controlValue.value;
        }
        if (controlValue !== null) {
            // eslint-disable-next-line no-param-reassign
            controlValue = this.inputTransformFn
                ? this.inputTransformFn(controlValue)
                : controlValue;
        }
        if (typeof controlValue === 'string' ||
            typeof controlValue === 'number' ||
            controlValue === null ||
            controlValue === undefined) {
            if (controlValue === null || controlValue === undefined || controlValue === '') {
                this._maskService._currentValue = '';
                this._maskService._previousValue = '';
            }
            // eslint-disable-next-line no-param-reassign
            let inputValue = controlValue;
            if (typeof inputValue === 'number' ||
                this._maskValue.startsWith("separator" /* MaskExpression.SEPARATOR */)) {
                // eslint-disable-next-line no-param-reassign
                inputValue = String(inputValue);
                const localeDecimalMarker = this._maskService.currentLocaleDecimalMarker();
                if (!Array.isArray(this._maskService.decimalMarker)) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue =
                        this._maskService.decimalMarker !== localeDecimalMarker
                            ? inputValue.replace(localeDecimalMarker, this._maskService.decimalMarker)
                            : inputValue;
                }
                if (this._maskService.leadZero &&
                    inputValue &&
                    this.maskExpression &&
                    this.dropSpecialCharacters !== false) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue = this._maskService._checkPrecision(this._maskService.maskExpression, inputValue);
                }
                if (this._maskService.decimalMarker === "," /* MaskExpression.COMMA */) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue = inputValue
                        .toString()
                        .replace("." /* MaskExpression.DOT */, "," /* MaskExpression.COMMA */);
                }
                if (this.maskExpression?.startsWith("separator" /* MaskExpression.SEPARATOR */) && this.leadZero) {
                    requestAnimationFrame(() => {
                        this._maskService.applyMask(inputValue?.toString() ?? '', this._maskService.maskExpression);
                    });
                }
                this._maskService.isNumberValue = true;
            }
            if (typeof inputValue !== 'string') {
                // eslint-disable-next-line no-param-reassign
                inputValue = '';
            }
            this._inputValue = inputValue;
            this._setMask();
            if ((inputValue && this._maskService.maskExpression) ||
                (this._maskService.maskExpression &&
                    (this._maskService.prefix || this._maskService.showMaskTyped))) {
                // Let the service we know we are writing value so that triggering onChange function won't happen during applyMask
                typeof this.inputTransformFn !== 'function'
                    ? (this._maskService.writingValue = true)
                    : '';
                this._maskService.formElementProperty = [
                    'value',
                    this._maskService.applyMask(inputValue, this._maskService.maskExpression),
                ];
                // Let the service know we've finished writing value
                typeof this.inputTransformFn !== 'function'
                    ? (this._maskService.writingValue = false)
                    : '';
            }
            else {
                this._maskService.formElementProperty = ['value', inputValue];
            }
            this._inputValue = inputValue;
        }
        else {
            console.warn('Ngx-mask writeValue work with string | number, your current value:', typeof controlValue);
        }
    }
    registerOnChange(fn) {
        this._maskService.onChange = this.onChange = fn;
    }
    registerOnTouched(fn) {
        this.onTouch = fn;
    }
    _getActiveElement(document = this.document) {
        const shadowRootEl = document?.activeElement?.shadowRoot;
        if (!shadowRootEl?.activeElement) {
            return document.activeElement;
        }
        else {
            return this._getActiveElement(shadowRootEl);
        }
    }
    checkSelectionOnDeletion(el) {
        el.selectionStart = Math.min(Math.max(this.prefix.length, el.selectionStart), this._inputValue.length - this.suffix.length);
        el.selectionEnd = Math.min(Math.max(this.prefix.length, el.selectionEnd), this._inputValue.length - this.suffix.length);
    }
    /** It disables the input element */
    setDisabledState(isDisabled) {
        this._maskService.formElementProperty = ['disabled', isDisabled];
    }
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    _applyMask() {
        this._maskService.maskExpression = this._maskService._repeatPatternSymbols(this._maskValue || '');
        this._maskService.formElementProperty = [
            'value',
            this._maskService.applyMask(this._inputValue, this._maskService.maskExpression),
        ];
    }
    _validateTime(value) {
        const rowMaskLen = this._maskValue
            .split("" /* MaskExpression.EMPTY_STRING */)
            .filter((s) => s !== ':').length;
        if (!value) {
            return null; // Don't validate empty values to allow for optional form control
        }
        if ((+(value[value.length - 1] ?? -1) === 0 && value.length < rowMaskLen) ||
            value.length <= rowMaskLen - 2) {
            return this._createValidationError(value);
        }
        return null;
    }
    _getActualInputLength() {
        return (this._maskService.actualValue.length ||
            this._maskService.actualValue.length + this._maskService.prefix.length);
    }
    _createValidationError(actualValue) {
        return {
            mask: {
                requiredMask: this._maskValue,
                actualValue,
            },
        };
    }
    _setMask() {
        this._maskExpressionArray.some((mask) => {
            const specialChart = mask
                .split("" /* MaskExpression.EMPTY_STRING */)
                .some((char) => this._maskService.specialCharacters.includes(char));
            if ((specialChart && this._inputValue && !mask.includes("S" /* MaskExpression.LETTER_S */)) ||
                mask.includes("{" /* MaskExpression.CURLY_BRACKETS_LEFT */)) {
                const test = this._maskService.removeMask(this._inputValue)?.length <=
                    this._maskService.removeMask(mask)?.length;
                if (test) {
                    this._maskValue =
                        this.maskExpression =
                            this._maskService.maskExpression =
                                mask.includes("{" /* MaskExpression.CURLY_BRACKETS_LEFT */)
                                    ? this._maskService._repeatPatternSymbols(mask)
                                    : mask;
                    return test;
                }
                else {
                    const expression = this._maskExpressionArray[this._maskExpressionArray.length - 1] ??
                        "" /* MaskExpression.EMPTY_STRING */;
                    this._maskValue =
                        this.maskExpression =
                            this._maskService.maskExpression =
                                expression.includes("{" /* MaskExpression.CURLY_BRACKETS_LEFT */)
                                    ? this._maskService._repeatPatternSymbols(expression)
                                    : expression;
                }
            }
            else {
                const check = this._maskService
                    .removeMask(this._inputValue)
                    ?.split("" /* MaskExpression.EMPTY_STRING */)
                    .every((character, index) => {
                    const indexMask = mask.charAt(index);
                    return this._maskService._checkSymbolMask(character, indexMask);
                });
                if (check) {
                    this._maskValue = this.maskExpression = this._maskService.maskExpression = mask;
                    return check;
                }
            }
        });
    }
    static { this.ɵfac = i0.ɵɵngDeclareFactory({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskDirective, deps: [], target: i0.ɵɵFactoryTarget.Directive }); }
    static { this.ɵdir = i0.ɵɵngDeclareDirective({ minVersion: "14.0.0", version: "16.2.12", type: NgxMaskDirective, isStandalone: true, selector: "input[mask], textarea[mask]", inputs: { maskExpression: ["mask", "maskExpression"], specialCharacters: "specialCharacters", patterns: "patterns", prefix: "prefix", suffix: "suffix", thousandSeparator: "thousandSeparator", decimalMarker: "decimalMarker", dropSpecialCharacters: "dropSpecialCharacters", hiddenInput: "hiddenInput", showMaskTyped: "showMaskTyped", placeHolderCharacter: "placeHolderCharacter", shownMaskExpression: "shownMaskExpression", showTemplate: "showTemplate", clearIfNotMatch: "clearIfNotMatch", validation: "validation", separatorLimit: "separatorLimit", allowNegativeNumbers: "allowNegativeNumbers", leadZeroDateTime: "leadZeroDateTime", leadZero: "leadZero", triggerOnMaskChange: "triggerOnMaskChange", apm: "apm", inputTransformFn: "inputTransformFn", outputTransformFn: "outputTransformFn", keepCharacterPositions: "keepCharacterPositions" }, outputs: { maskFilled: "maskFilled" }, host: { listeners: { "paste": "onPaste()", "focus": "onFocus($event)", "ngModelChange": "onModelChange($event)", "input": "onInput($event)", "compositionstart": "onCompositionStart($event)", "compositionend": "onCompositionEnd($event)", "blur": "onBlur($event)", "click": "onClick($event)", "keydown": "onKeyDown($event)" } }, providers: [
            {
                provide: NG_VALUE_ACCESSOR,
                useExisting: NgxMaskDirective,
                multi: true,
            },
            {
                provide: NG_VALIDATORS,
                useExisting: NgxMaskDirective,
                multi: true,
            },
            NgxMaskService,
        ], exportAs: ["mask", "ngxMask"], usesOnChanges: true, ngImport: i0 }); }
}
i0.ɵɵngDeclareClassMetadata({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskDirective, decorators: [{
            type: Directive,
            args: [{
                    selector: 'input[mask], textarea[mask]',
                    standalone: true,
                    providers: [
                        {
                            provide: NG_VALUE_ACCESSOR,
                            useExisting: NgxMaskDirective,
                            multi: true,
                        },
                        {
                            provide: NG_VALIDATORS,
                            useExisting: NgxMaskDirective,
                            multi: true,
                        },
                        NgxMaskService,
                    ],
                    exportAs: 'mask,ngxMask',
                }]
        }], propDecorators: { maskExpression: [{
                type: Input,
                args: ['mask']
            }], specialCharacters: [{
                type: Input
            }], patterns: [{
                type: Input
            }], prefix: [{
                type: Input
            }], suffix: [{
                type: Input
            }], thousandSeparator: [{
                type: Input
            }], decimalMarker: [{
                type: Input
            }], dropSpecialCharacters: [{
                type: Input
            }], hiddenInput: [{
                type: Input
            }], showMaskTyped: [{
                type: Input
            }], placeHolderCharacter: [{
                type: Input
            }], shownMaskExpression: [{
                type: Input
            }], showTemplate: [{
                type: Input
            }], clearIfNotMatch: [{
                type: Input
            }], validation: [{
                type: Input
            }], separatorLimit: [{
                type: Input
            }], allowNegativeNumbers: [{
                type: Input
            }], leadZeroDateTime: [{
                type: Input
            }], leadZero: [{
                type: Input
            }], triggerOnMaskChange: [{
                type: Input
            }], apm: [{
                type: Input
            }], inputTransformFn: [{
                type: Input
            }], outputTransformFn: [{
                type: Input
            }], keepCharacterPositions: [{
                type: Input
            }], maskFilled: [{
                type: Output
            }], onPaste: [{
                type: HostListener,
                args: ['paste']
            }], onFocus: [{
                type: HostListener,
                args: ['focus', ['$event']]
            }], onModelChange: [{
                type: HostListener,
                args: ['ngModelChange', ['$event']]
            }], onInput: [{
                type: HostListener,
                args: ['input', ['$event']]
            }], onCompositionStart: [{
                type: HostListener,
                args: ['compositionstart', ['$event']]
            }], onCompositionEnd: [{
                type: HostListener,
                args: ['compositionend', ['$event']]
            }], onBlur: [{
                type: HostListener,
                args: ['blur', ['$event']]
            }], onClick: [{
                type: HostListener,
                args: ['click', ['$event']]
            }], onKeyDown: [{
                type: HostListener,
                args: ['keydown', ['$event']]
            }] } });
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibmd4LW1hc2suZGlyZWN0aXZlLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vcHJvamVjdHMvbmd4LW1hc2stbGliL3NyYy9saWIvbmd4LW1hc2suZGlyZWN0aXZlLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBLE9BQU8sRUFBRSxRQUFRLEVBQUUsTUFBTSxpQkFBaUIsQ0FBQztBQUMzQyxPQUFPLEVBQ0gsU0FBUyxFQUNULFlBQVksRUFDWixZQUFZLEVBQ1osS0FBSyxFQUVMLE1BQU0sRUFFTixNQUFNLEdBQ1QsTUFBTSxlQUFlLENBQUM7QUFDdkIsT0FBTyxFQUdILGFBQWEsRUFDYixpQkFBaUIsR0FHcEIsTUFBTSxnQkFBZ0IsQ0FBQztBQUd4QixPQUFPLEVBQVcsZUFBZSxFQUFFLFNBQVMsRUFBRSxpQkFBaUIsRUFBRSxNQUFNLG1CQUFtQixDQUFDO0FBQzNGLE9BQU8sRUFBRSxjQUFjLEVBQUUsTUFBTSxvQkFBb0IsQ0FBQzs7QUFxQnBELE1BQU0sT0FBTyxnQkFBZ0I7SUFsQjdCO1FBbUJJLDJEQUEyRDtRQUNyQyxtQkFBYyxHQUE4QixFQUFFLENBQUM7UUFFckQsc0JBQWlCLEdBQWlDLEVBQUUsQ0FBQztRQUVyRCxhQUFRLEdBQXdCLEVBQUUsQ0FBQztRQUVuQyxXQUFNLEdBQXNCLEVBQUUsQ0FBQztRQUUvQixXQUFNLEdBQXNCLEVBQUUsQ0FBQztRQUUvQixzQkFBaUIsR0FBaUMsR0FBRyxDQUFDO1FBRXRELGtCQUFhLEdBQTZCLEdBQUcsQ0FBQztRQUU5QywwQkFBcUIsR0FBNEMsSUFBSSxDQUFDO1FBRXRFLGdCQUFXLEdBQWtDLElBQUksQ0FBQztRQUVsRCxrQkFBYSxHQUFvQyxJQUFJLENBQUM7UUFFdEQseUJBQW9CLEdBQTJDLElBQUksQ0FBQztRQUVwRSx3QkFBbUIsR0FBMEMsSUFBSSxDQUFDO1FBRWxFLGlCQUFZLEdBQW1DLElBQUksQ0FBQztRQUVwRCxvQkFBZSxHQUFzQyxJQUFJLENBQUM7UUFF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QUs7Z0JBRVUsVUFBVTtzQkFBekIsS0FBSztnQkFFVSxjQUFjO3NCQUE3QixLQUFLO2dCQUVVLG9CQUFvQjtzQkFBbkMsS0FBSztnQkFFVSxnQkFBZ0I7c0JBQS9CLEtBQUs7Z0JBRVUsUUFBUTtzQkFBdkIsS0FBSztnQkFFVSxtQkFBbUI7c0JBQWxDLEtBQUs7Z0JBRVUsR0FBRztzQkFBbEIsS0FBSztnQkFFVSxnQkFBZ0I7c0JBQS9CLEtBQUs7Z0JBRVUsaUJBQWlCO3NCQUFoQyxLQUFLO2dCQUVVLHNCQUFzQjtzQkFBckMsS0FBSztnQkFFVyxVQUFVO3NCQUExQixNQUFNO2dCQW9UQSxPQUFPO3NCQURiLFlBQVk7dUJBQUMsT0FBTztnQkFLcUIsT0FBTztzQkFBaEQsWUFBWTt1QkFBQyxPQUFPLEVBQUUsQ0FBQyxRQUFRLENBQUM7Z0JBSzFCLGFBQWE7c0JBRG5CLFlBQVk7dUJBQUMsZUFBZSxFQUFFLENBQUMsUUFBUSxDQUFDO2dCQWNsQyxPQUFPO3NCQURiLFlBQVk7dUJBQUMsT0FBTyxFQUFFLENBQUMsUUFBUSxDQUFDO2dCQW9SMUIsa0JBQWtCO3NCQUR4QixZQUFZO3VCQUFDLGtCQUFrQixFQUFFLENBQUMsUUFBUSxDQUFDO2dCQU9yQyxnQkFBZ0I7c0JBRHRCLFlBQVk7dUJBQUMsZ0JBQWdCLEVBQUUsQ0FBQyxRQUFRLENBQUM7Z0JBUW5DLE1BQU07c0JBRFosWUFBWTt1QkFBQyxNQUFNLEVBQUUsQ0FBQyxRQUFRLENBQUM7Z0JBaUN6QixPQUFPO3NCQURiLFlBQVk7dUJBQUMsT0FBTyxFQUFFLENBQUMsUUFBUSxDQUFDO2dCQW9FMUIsU0FBUztzQkFEZixZQUFZO3VCQUFDLFNBQVMsRUFBRSxDQUFDLFFBQVEsQ0FBQyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7IERPQ1VNRU5UIH0gZnJvbSAnQGFuZ3VsYXIvY29tbW9uJztcbmltcG9ydCB7XG4gICAgRGlyZWN0aXZlLFxuICAgIEV2ZW50RW1pdHRlcixcbiAgICBIb3N0TGlzdGVuZXIsXG4gICAgSW5wdXQsXG4gICAgT25DaGFuZ2VzLFxuICAgIE91dHB1dCxcbiAgICBTaW1wbGVDaGFuZ2VzLFxuICAgIGluamVjdCxcbn0gZnJvbSAnQGFuZ3VsYXIvY29yZSc7XG5pbXBvcnQge1xuICAgIENvbnRyb2xWYWx1ZUFjY2Vzc29yLFxuICAgIEZvcm1Db250cm9sLFxuICAgIE5HX1ZBTElEQVRPUlMsXG4gICAgTkdfVkFMVUVfQUNDRVNTT1IsXG4gICAgVmFsaWRhdGlvbkVycm9ycyxcbiAgICBWYWxpZGF0b3IsXG59IGZyb20gJ0Bhbmd1bGFyL2Zvcm1zJztcblxuaW1wb3J0IHsgQ3VzdG9tS2V5Ym9hcmRFdmVudCB9IGZyb20gJy4vY3VzdG9tLWtleWJvYXJkLWV2ZW50JztcbmltcG9ydCB7IElDb25maWcsIE5HWF9NQVNLX0NPTkZJRywgdGltZU1hc2tzLCB3aXRob3V0VmFsaWRhdGlvbiB9IGZyb20gJy4vbmd4LW1hc2suY29uZmlnJztcbmltcG9ydCB7IE5neE1hc2tTZXJ2aWNlIH0gZnJvbSAnLi9uZ3gtbWFzay5zZXJ2aWNlJztcbmltcG9ydCB7IE1hc2tFeHByZXNzaW9uIH0gZnJvbSAnLi9uZ3gtbWFzay1leHByZXNzaW9uLmVudW0nO1xuXG5ARGlyZWN0aXZlKHtcbiAgICBzZWxlY3RvcjogJ2lucHV0W21hc2tdLCB0ZXh0YXJlYVttYXNrXScsXG4gICAgc3RhbmRhbG9uZTogdHJ1ZSxcbiAgICBwcm92aWRlcnM6IFtcbiAgICAgICAge1xuICAgICAgICAgICAgcHJvdmlkZTogTkdfVkFMVUVfQUNDRVNTT1IsXG4gICAgICAgICAgICB1c2VFeGlzdGluZzogTmd4TWFza0RpcmVjdGl2ZSxcbiAgICAgICAgICAgIG11bHRpOiB0cnVlLFxuICAgICAgICB9LFxuICAgICAgICB7XG4gICAgICAgICAgICBwcm92aWRlOiBOR19WQUxJREFUT1JTLFxuICAgICAgICAgICAgdXNlRXhpc3Rpbmc6IE5neE1hc2tEaXJlY3RpdmUsXG4gICAgICAgICAgICBtdWx0aTogdHJ1ZSxcbiAgICAgICAgfSxcbiAgICAgICAgTmd4TWFza1NlcnZpY2UsXG4gICAgXSxcbiAgICBleHBvcnRBczogJ21hc2ssbmd4TWFzaycsXG59KVxuZXhwb3J0IGNsYXNzIE5neE1hc2tEaXJlY3RpdmUgaW1wbGVtZW50cyBDb250cm9sVmFsdWVBY2Nlc3NvciwgT25DaGFuZ2VzLCBWYWxpZGF0b3Ige1xuICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBAYW5ndWxhci1lc2xpbnQvbm8taW5wdXQtcmVuYW1lXG4gICAgQElucHV0KCdtYXNrJykgcHVibGljIG1hc2tFeHByZXNzaW9uOiBzdHJpbmcgfCB1bmRlZmluZWQgfCBudWxsID0gJyc7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgc3BlY2lhbENoYXJhY3RlcnM6IElDb25maWdbJ3NwZWNpYWxDaGFyYWN0ZXJzJ10gPSBbXTtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyBwYXR0ZXJuczogSUNvbmZpZ1sncGF0dGVybnMnXSA9IHt9O1xuXG4gICAgQElucHV0KCkgcHVibGljIHByZWZpeDogSUNvbmZpZ1sncHJlZml4J10gPSAnJztcblxuICAgIEBJbnB1dCgpIHB1YmxpYyBzdWZmaXg6IElDb25maWdbJ3N1ZmZpeCddID0gJyc7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgdGhvdXNhbmRTZXBhcmF0b3I6IElDb25maWdbJ3Rob3VzYW5kU2VwYXJhdG9yJ10gPSAnICc7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgZGVjaW1hbE1hcmtlcjogSUNvbmZpZ1snZGVjaW1hbE1hcmtlciddID0gJy4nO1xuXG4gICAgQElucHV0KCkgcHVibGljIGRyb3BTcGVjaWFsQ2hhcmFjdGVyczogSUNvbmZpZ1snZHJvcFNwZWNpYWxDaGFyYWN0ZXJzJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyBoaWRkZW5JbnB1dDogSUNvbmZpZ1snaGlkZGVuSW5wdXQnXSB8IG51bGwgPSBudWxsO1xuXG4gICAgQElucHV0KCkgcHVibGljIHNob3dNYXNrVHlwZWQ6IElDb25maWdbJ3Nob3dNYXNrVHlwZWQnXSB8IG51bGwgPSBudWxsO1xuXG4gICAgQElucHV0KCkgcHVibGljIHBsYWNlSG9sZGVyQ2hhcmFjdGVyOiBJQ29uZmlnWydwbGFjZUhvbGRlckNoYXJhY3RlciddIHwgbnVsbCA9IG51bGw7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgc2hvd25NYXNrRXhwcmVzc2lvbjogSUNvbmZpZ1snc2hvd25NYXNrRXhwcmVzc2lvbiddIHwgbnVsbCA9IG51bGw7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgc2hvd1RlbXBsYXRlOiBJQ29uZmlnWydzaG93VGVtcGxhdGUnXSB8IG51bGwgPSBudWxsO1xuXG4gICAgQElucHV0KCkgcHVibGljIGNsZWFySWZOb3RNYXRjaDogSUNvbmZpZ1snY2xlYXJJZk5vdE1hdGNoJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyB2YWxpZGF0aW9uOiBJQ29uZmlnWyd2YWxpZGF0aW9uJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyBzZXBhcmF0b3JMaW1pdDogSUNvbmZpZ1snc2VwYXJhdG9yTGltaXQnXSB8IG51bGwgPSBudWxsO1xuXG4gICAgQElucHV0KCkgcHVibGljIGFsbG93TmVnYXRpdmVOdW1iZXJzOiBJQ29uZmlnWydhbGxvd05lZ2F0aXZlTnVtYmVycyddIHwgbnVsbCA9IG51bGw7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgbGVhZFplcm9EYXRlVGltZTogSUNvbmZpZ1snbGVhZFplcm9EYXRlVGltZSddIHwgbnVsbCA9IG51bGw7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgbGVhZFplcm86IElDb25maWdbJ2xlYWRaZXJvJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyB0cmlnZ2VyT25NYXNrQ2hhbmdlOiBJQ29uZmlnWyd0cmlnZ2VyT25NYXNrQ2hhbmdlJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyBhcG06IElDb25maWdbJ2FwbSddIHwgbnVsbCA9IG51bGw7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgaW5wdXRUcmFuc2Zvcm1GbjogSUNvbmZpZ1snaW5wdXRUcmFuc2Zvcm1GbiddIHwgbnVsbCA9IG51bGw7XG5cbiAgICBASW5wdXQoKSBwdWJsaWMgb3V0cHV0VHJhbnNmb3JtRm46IElDb25maWdbJ291dHB1dFRyYW5zZm9ybUZuJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBJbnB1dCgpIHB1YmxpYyBrZWVwQ2hhcmFjdGVyUG9zaXRpb25zOiBJQ29uZmlnWydrZWVwQ2hhcmFjdGVyUG9zaXRpb25zJ10gfCBudWxsID0gbnVsbDtcblxuICAgIEBPdXRwdXQoKSBwdWJsaWMgbWFza0ZpbGxlZDogSUNvbmZpZ1snbWFza0ZpbGxlZCddID0gbmV3IEV2ZW50RW1pdHRlcjx2b2lkPigpO1xuXG4gICAgcHJpdmF0ZSBfbWFza1ZhbHVlID0gJyc7XG5cbiAgICBwcml2YXRlIF9pbnB1dFZhbHVlITogc3RyaW5nO1xuXG4gICAgcHJpdmF0ZSBfcG9zaXRpb246IG51bWJlciB8IG51bGwgPSBudWxsO1xuXG4gICAgcHJpdmF0ZSBfY29kZSE6IHN0cmluZztcblxuICAgIHByaXZhdGUgX21hc2tFeHByZXNzaW9uQXJyYXk6IHN0cmluZ1tdID0gW107XG5cbiAgICBwcml2YXRlIF9qdXN0UGFzdGVkID0gZmFsc2U7XG5cbiAgICBwcml2YXRlIF9pc0ZvY3VzZWQgPSBmYWxzZTtcblxuICAgIC8qKkZvciBJTUUgY29tcG9zaXRpb24gZXZlbnQgKi9cbiAgICBwcml2YXRlIF9pc0NvbXBvc2luZyA9IGZhbHNlO1xuXG4gICAgcHJpdmF0ZSByZWFkb25seSBkb2N1bWVudCA9IGluamVjdChET0NVTUVOVCk7XG5cbiAgICBwdWJsaWMgX21hc2tTZXJ2aWNlID0gaW5qZWN0KE5neE1hc2tTZXJ2aWNlLCB7IHNlbGY6IHRydWUgfSk7XG5cbiAgICBwcm90ZWN0ZWQgX2NvbmZpZyA9IGluamVjdDxJQ29uZmlnPihOR1hfTUFTS19DT05GSUcpO1xuXG4gICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIEB0eXBlc2NyaXB0LWVzbGludC9uby1lbXB0eS1mdW5jdGlvbiwgQHR5cGVzY3JpcHQtZXNsaW50L25vLWV4cGxpY2l0LWFueVxuICAgIHB1YmxpYyBvbkNoYW5nZSA9IChfOiBhbnkpID0+IHt9O1xuXG4gICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIEB0eXBlc2NyaXB0LWVzbGludC9uby1lbXB0eS1mdW5jdGlvblxuICAgIHB1YmxpYyBvblRvdWNoID0gKCkgPT4ge307XG5cbiAgICBwdWJsaWMgbmdPbkNoYW5nZXMoY2hhbmdlczogU2ltcGxlQ2hhbmdlcyk6IHZvaWQge1xuICAgICAgICBjb25zdCB7XG4gICAgICAgICAgICBtYXNrRXhwcmVzc2lvbixcbiAgICAgICAgICAgIHNwZWNpYWxDaGFyYWN0ZXJzLFxuICAgICAgICAgICAgcGF0dGVybnMsXG4gICAgICAgICAgICBwcmVmaXgsXG4gICAgICAgICAgICBzdWZmaXgsXG4gICAgICAgICAgICB0aG91c2FuZFNlcGFyYXRvcixcbiAgICAgICAgICAgIGRlY2ltYWxNYXJrZXIsXG4gICAgICAgICAgICBkcm9wU3BlY2lhbENoYXJhY3RlcnMsXG4gICAgICAgICAgICBoaWRkZW5JbnB1dCxcbiAgICAgICAgICAgIHNob3dNYXNrVHlwZWQsXG4gICAgICAgICAgICBwbGFjZUhvbGRlckNoYXJhY3RlcixcbiAgICAgICAgICAgIHNob3duTWFza0V4cHJlc3Npb24sXG4gICAgICAgICAgICBzaG93VGVtcGxhdGUsXG4gICAgICAgICAgICBjbGVhcklmTm90TWF0Y2gsXG4gICAgICAgICAgICB2YWxpZGF0aW9uLFxuICAgICAgICAgICAgc2VwYXJhdG9yTGltaXQsXG4gICAgICAgICAgICBhbGxvd05lZ2F0aXZlTnVtYmVycyxcbiAgICAgICAgICAgIGxlYWRaZXJvRGF0ZVRpbWUsXG4gICAgICAgICAgICBsZWFkWmVybyxcbiAgICAgICAgICAgIHRyaWdnZXJPbk1hc2tDaGFuZ2UsXG4gICAgICAgICAgICBhcG0sXG4gICAgICAgICAgICBpbnB1dFRyYW5zZm9ybUZuLFxuICAgICAgICAgICAgb3V0cHV0VHJhbnNmb3JtRm4sXG4gICAgICAgICAgICBrZWVwQ2hhcmFjdGVyUG9zaXRpb25zLFxuICAgICAgICB9ID0gY2hhbmdlcztcbiAgICAgICAgaWYgKG1hc2tFeHByZXNzaW9uKSB7XG4gICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb24uY3VycmVudFZhbHVlICE9PSBtYXNrRXhwcmVzc2lvbi5wcmV2aW91c1ZhbHVlICYmXG4gICAgICAgICAgICAgICAgIW1hc2tFeHByZXNzaW9uLmZpcnN0Q2hhbmdlXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrQ2hhbmdlZCA9IHRydWU7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb24uY3VycmVudFZhbHVlICYmXG4gICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb24uY3VycmVudFZhbHVlLnNwbGl0KE1hc2tFeHByZXNzaW9uLk9SKS5sZW5ndGggPiAxXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrRXhwcmVzc2lvbkFycmF5ID0gbWFza0V4cHJlc3Npb24uY3VycmVudFZhbHVlXG4gICAgICAgICAgICAgICAgICAgIC5zcGxpdChNYXNrRXhwcmVzc2lvbi5PUilcbiAgICAgICAgICAgICAgICAgICAgLnNvcnQoKGE6IHN0cmluZywgYjogc3RyaW5nKSA9PiB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gYS5sZW5ndGggLSBiLmxlbmd0aDtcbiAgICAgICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgICAgdGhpcy5fc2V0TWFzaygpO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrRXhwcmVzc2lvbkFycmF5ID0gW107XG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1ZhbHVlID0gbWFza0V4cHJlc3Npb24uY3VycmVudFZhbHVlIHx8IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORztcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiA9IHRoaXMuX21hc2tWYWx1ZTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICBpZiAoc3BlY2lhbENoYXJhY3RlcnMpIHtcbiAgICAgICAgICAgIGlmICghc3BlY2lhbENoYXJhY3RlcnMuY3VycmVudFZhbHVlIHx8ICFBcnJheS5pc0FycmF5KHNwZWNpYWxDaGFyYWN0ZXJzLmN1cnJlbnRWYWx1ZSkpIHtcbiAgICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnNwZWNpYWxDaGFyYWN0ZXJzID0gc3BlY2lhbENoYXJhY3RlcnMuY3VycmVudFZhbHVlIHx8IFtdO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIGlmIChhbGxvd05lZ2F0aXZlTnVtYmVycykge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWxsb3dOZWdhdGl2ZU51bWJlcnMgPSBhbGxvd05lZ2F0aXZlTnVtYmVycy5jdXJyZW50VmFsdWU7XG4gICAgICAgICAgICBpZiAodGhpcy5fbWFza1NlcnZpY2UuYWxsb3dOZWdhdGl2ZU51bWJlcnMpIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5zcGVjaWFsQ2hhcmFjdGVycyA9IHRoaXMuX21hc2tTZXJ2aWNlLnNwZWNpYWxDaGFyYWN0ZXJzLmZpbHRlcihcbiAgICAgICAgICAgICAgICAgICAgKGM6IHN0cmluZykgPT4gYyAhPT0gTWFza0V4cHJlc3Npb24uTUlOVVNcbiAgICAgICAgICAgICAgICApO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIC8vIE9ubHkgb3ZlcndyaXRlIHRoZSBtYXNrIGF2YWlsYWJsZSBwYXR0ZXJucyBpZiBhIHBhdHRlcm4gaGFzIGFjdHVhbGx5IGJlZW4gcGFzc2VkIGluXG4gICAgICAgIGlmIChwYXR0ZXJucyAmJiBwYXR0ZXJucy5jdXJyZW50VmFsdWUpIHtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnBhdHRlcm5zID0gcGF0dGVybnMuY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChhcG0gJiYgYXBtLmN1cnJlbnRWYWx1ZSkge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYXBtID0gYXBtLmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAocHJlZml4KSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXggPSBwcmVmaXguY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChzdWZmaXgpIHtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnN1ZmZpeCA9IHN1ZmZpeC5jdXJyZW50VmFsdWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHRob3VzYW5kU2VwYXJhdG9yKSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS50aG91c2FuZFNlcGFyYXRvciA9IHRob3VzYW5kU2VwYXJhdG9yLmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoZGVjaW1hbE1hcmtlcikge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuZGVjaW1hbE1hcmtlciA9IGRlY2ltYWxNYXJrZXIuY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChkcm9wU3BlY2lhbENoYXJhY3RlcnMpIHtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmRyb3BTcGVjaWFsQ2hhcmFjdGVycyA9IGRyb3BTcGVjaWFsQ2hhcmFjdGVycy5jdXJyZW50VmFsdWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKGhpZGRlbklucHV0KSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5oaWRkZW5JbnB1dCA9IGhpZGRlbklucHV0LmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoc2hvd01hc2tUeXBlZCkge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uuc2hvd01hc2tUeXBlZCA9IHNob3dNYXNrVHlwZWQuY3VycmVudFZhbHVlO1xuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgIHNob3dNYXNrVHlwZWQucHJldmlvdXNWYWx1ZSA9PT0gZmFsc2UgJiZcbiAgICAgICAgICAgICAgICBzaG93TWFza1R5cGVkLmN1cnJlbnRWYWx1ZSA9PT0gdHJ1ZSAmJlxuICAgICAgICAgICAgICAgIHRoaXMuX2lzRm9jdXNlZFxuICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgcmVxdWVzdEFuaW1hdGlvbkZyYW1lKCgpID0+IHtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuX2VsZW1lbnRSZWY/Lm5hdGl2ZUVsZW1lbnQuY2xpY2soKTtcbiAgICAgICAgICAgICAgICB9KTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICBpZiAocGxhY2VIb2xkZXJDaGFyYWN0ZXIpIHtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnBsYWNlSG9sZGVyQ2hhcmFjdGVyID0gcGxhY2VIb2xkZXJDaGFyYWN0ZXIuY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChzaG93bk1hc2tFeHByZXNzaW9uKSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5zaG93bk1hc2tFeHByZXNzaW9uID0gc2hvd25NYXNrRXhwcmVzc2lvbi5jdXJyZW50VmFsdWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHNob3dUZW1wbGF0ZSkge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uuc2hvd1RlbXBsYXRlID0gc2hvd1RlbXBsYXRlLmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoY2xlYXJJZk5vdE1hdGNoKSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5jbGVhcklmTm90TWF0Y2ggPSBjbGVhcklmTm90TWF0Y2guY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmICh2YWxpZGF0aW9uKSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS52YWxpZGF0aW9uID0gdmFsaWRhdGlvbi5jdXJyZW50VmFsdWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHNlcGFyYXRvckxpbWl0KSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5zZXBhcmF0b3JMaW1pdCA9IHNlcGFyYXRvckxpbWl0LmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAobGVhZFplcm9EYXRlVGltZSkge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubGVhZFplcm9EYXRlVGltZSA9IGxlYWRaZXJvRGF0ZVRpbWUuY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChsZWFkWmVybykge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubGVhZFplcm8gPSBsZWFkWmVyby5jdXJyZW50VmFsdWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHRyaWdnZXJPbk1hc2tDaGFuZ2UpIHtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnRyaWdnZXJPbk1hc2tDaGFuZ2UgPSB0cmlnZ2VyT25NYXNrQ2hhbmdlLmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoaW5wdXRUcmFuc2Zvcm1Gbikge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuaW5wdXRUcmFuc2Zvcm1GbiA9IGlucHV0VHJhbnNmb3JtRm4uY3VycmVudFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChvdXRwdXRUcmFuc2Zvcm1Gbikge1xuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uub3V0cHV0VHJhbnNmb3JtRm4gPSBvdXRwdXRUcmFuc2Zvcm1Gbi5jdXJyZW50VmFsdWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKGtlZXBDaGFyYWN0ZXJQb3NpdGlvbnMpIHtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmtlZXBDaGFyYWN0ZXJQb3NpdGlvbnMgPSBrZWVwQ2hhcmFjdGVyUG9zaXRpb25zLmN1cnJlbnRWYWx1ZTtcbiAgICAgICAgfVxuICAgICAgICB0aGlzLl9hcHBseU1hc2soKTtcbiAgICB9XG5cbiAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgY29tcGxleGl0eVxuICAgIHB1YmxpYyB2YWxpZGF0ZSh7IHZhbHVlIH06IEZvcm1Db250cm9sKTogVmFsaWRhdGlvbkVycm9ycyB8IG51bGwge1xuICAgICAgICBpZiAoIXRoaXMuX21hc2tTZXJ2aWNlLnZhbGlkYXRpb24gfHwgIXRoaXMuX21hc2tWYWx1ZSkge1xuICAgICAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHRoaXMuX21hc2tTZXJ2aWNlLmlwRXJyb3IpIHtcbiAgICAgICAgICAgIHJldHVybiB0aGlzLl9jcmVhdGVWYWxpZGF0aW9uRXJyb3IodmFsdWUpO1xuICAgICAgICB9XG4gICAgICAgIGlmICh0aGlzLl9tYXNrU2VydmljZS5jcGZDbnBqRXJyb3IpIHtcbiAgICAgICAgICAgIHJldHVybiB0aGlzLl9jcmVhdGVWYWxpZGF0aW9uRXJyb3IodmFsdWUpO1xuICAgICAgICB9XG4gICAgICAgIGlmICh0aGlzLl9tYXNrVmFsdWUuc3RhcnRzV2l0aChNYXNrRXhwcmVzc2lvbi5TRVBBUkFUT1IpKSB7XG4gICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgfVxuICAgICAgICBpZiAod2l0aG91dFZhbGlkYXRpb24uaW5jbHVkZXModGhpcy5fbWFza1ZhbHVlKSkge1xuICAgICAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHRoaXMuX21hc2tTZXJ2aWNlLmNsZWFySWZOb3RNYXRjaCkge1xuICAgICAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHRpbWVNYXNrcy5pbmNsdWRlcyh0aGlzLl9tYXNrVmFsdWUpKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5fdmFsaWRhdGVUaW1lKHZhbHVlKTtcbiAgICAgICAgfVxuICAgICAgICBpZiAodmFsdWUgJiYgdmFsdWUudG9TdHJpbmcoKS5sZW5ndGggPj0gMSkge1xuICAgICAgICAgICAgbGV0IGNvdW50ZXJPZk9wdCA9IDA7XG4gICAgICAgICAgICBpZiAodGhpcy5fbWFza1ZhbHVlLnN0YXJ0c1dpdGgoTWFza0V4cHJlc3Npb24uUEVSQ0VOVCkpIHtcbiAgICAgICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGZvciAoY29uc3Qga2V5IGluIHRoaXMuX21hc2tTZXJ2aWNlLnBhdHRlcm5zKSB7XG4gICAgICAgICAgICAgICAgaWYgKHRoaXMuX21hc2tTZXJ2aWNlLnBhdHRlcm5zW2tleV0/Lm9wdGlvbmFsKSB7XG4gICAgICAgICAgICAgICAgICAgIGlmICh0aGlzLl9tYXNrVmFsdWUuaW5kZXhPZihrZXkpICE9PSB0aGlzLl9tYXNrVmFsdWUubGFzdEluZGV4T2Yoa2V5KSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgb3B0OiBzdHJpbmcgPSB0aGlzLl9tYXNrVmFsdWVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAuc3BsaXQoTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HKVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5maWx0ZXIoKGk6IHN0cmluZykgPT4gaSA9PT0ga2V5KVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5qb2luKE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORyk7XG4gICAgICAgICAgICAgICAgICAgICAgICBjb3VudGVyT2ZPcHQgKz0gb3B0Lmxlbmd0aDtcbiAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICh0aGlzLl9tYXNrVmFsdWUuaW5kZXhPZihrZXkpICE9PSAtMSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgY291bnRlck9mT3B0Kys7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1ZhbHVlLmluZGV4T2Yoa2V5KSAhPT0gLTEgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlLnRvU3RyaW5nKCkubGVuZ3RoID49IHRoaXMuX21hc2tWYWx1ZS5pbmRleE9mKGtleSlcbiAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICBpZiAoY291bnRlck9mT3B0ID09PSB0aGlzLl9tYXNrVmFsdWUubGVuZ3RoKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrVmFsdWUuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5DVVJMWV9CUkFDS0VUU19MRUZUKSA9PT0gMSAmJlxuICAgICAgICAgICAgICAgIHZhbHVlLnRvU3RyaW5nKCkubGVuZ3RoID09PVxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrVmFsdWUubGVuZ3RoICtcbiAgICAgICAgICAgICAgICAgICAgICAgIE51bWJlcihcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tWYWx1ZS5zcGxpdChNYXNrRXhwcmVzc2lvbi5DVVJMWV9CUkFDS0VUU19MRUZUKVsxXSA/P1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkdcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICApLnNwbGl0KE1hc2tFeHByZXNzaW9uLkNVUkxZX0JSQUNLRVRTX1JJR0hUKVswXVxuICAgICAgICAgICAgICAgICAgICAgICAgKSAtXG4gICAgICAgICAgICAgICAgICAgICAgICA0XG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgICAgIH0gZWxzZSBpZiAoXG4gICAgICAgICAgICAgICAgKHRoaXMuX21hc2tWYWx1ZS5pbmRleE9mKE1hc2tFeHByZXNzaW9uLlNZTUJPTF9TVEFSKSA+IDEgJiZcbiAgICAgICAgICAgICAgICAgICAgdmFsdWUudG9TdHJpbmcoKS5sZW5ndGggPFxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1ZhbHVlLmluZGV4T2YoTWFza0V4cHJlc3Npb24uU1lNQk9MX1NUQVIpKSB8fFxuICAgICAgICAgICAgICAgICh0aGlzLl9tYXNrVmFsdWUuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5TWU1CT0xfUVVFU1RJT04pID4gMSAmJlxuICAgICAgICAgICAgICAgICAgICB2YWx1ZS50b1N0cmluZygpLmxlbmd0aCA8XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrVmFsdWUuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5TWU1CT0xfUVVFU1RJT04pKSB8fFxuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tWYWx1ZS5pbmRleE9mKE1hc2tFeHByZXNzaW9uLkNVUkxZX0JSQUNLRVRTX0xFRlQpID09PSAxXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICByZXR1cm4gdGhpcy5fY3JlYXRlVmFsaWRhdGlvbkVycm9yKHZhbHVlKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrVmFsdWUuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5TWU1CT0xfU1RBUikgPT09IC0xIHx8XG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1ZhbHVlLmluZGV4T2YoTWFza0V4cHJlc3Npb24uU1lNQk9MX1FVRVNUSU9OKSA9PT0gLTFcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIHZhbHVlID0gdHlwZW9mIHZhbHVlID09PSAnbnVtYmVyJyA/IFN0cmluZyh2YWx1ZSkgOiB2YWx1ZTtcbiAgICAgICAgICAgICAgICBjb25zdCBhcnJheSA9IHRoaXMuX21hc2tWYWx1ZS5zcGxpdCgnKicpO1xuICAgICAgICAgICAgICAgIGNvbnN0IGxlbmd0aDogbnVtYmVyID0gdGhpcy5fbWFza1NlcnZpY2UuZHJvcFNwZWNpYWxDaGFyYWN0ZXJzXG4gICAgICAgICAgICAgICAgICAgID8gdGhpcy5fbWFza1ZhbHVlLmxlbmd0aCAtXG4gICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuY2hlY2tEcm9wU3BlY2lhbENoYXJBbW91bnQodGhpcy5fbWFza1ZhbHVlKSAtXG4gICAgICAgICAgICAgICAgICAgICAgY291bnRlck9mT3B0XG4gICAgICAgICAgICAgICAgICAgIDogdGhpcy5wcmVmaXhcbiAgICAgICAgICAgICAgICAgICAgPyB0aGlzLl9tYXNrVmFsdWUubGVuZ3RoICsgdGhpcy5wcmVmaXgubGVuZ3RoIC0gY291bnRlck9mT3B0XG4gICAgICAgICAgICAgICAgICAgIDogdGhpcy5fbWFza1ZhbHVlLmxlbmd0aCAtIGNvdW50ZXJPZk9wdDtcblxuICAgICAgICAgICAgICAgIGlmIChhcnJheS5sZW5ndGggPT09IDEpIHtcbiAgICAgICAgICAgICAgICAgICAgaWYgKHZhbHVlLnRvU3RyaW5nKCkubGVuZ3RoIDwgbGVuZ3RoKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdGhpcy5fY3JlYXRlVmFsaWRhdGlvbkVycm9yKHZhbHVlKTtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBpZiAoYXJyYXkubGVuZ3RoID4gMSkge1xuICAgICAgICAgICAgICAgICAgICBjb25zdCBsYXN0SW5kZXhBcnJheSA9IGFycmF5W2FycmF5Lmxlbmd0aCAtIDFdO1xuICAgICAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgICAgICBsYXN0SW5kZXhBcnJheSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMobGFzdEluZGV4QXJyYXlbMF0gYXMgc3RyaW5nKSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgU3RyaW5nKHZhbHVlKS5pbmNsdWRlcyhsYXN0SW5kZXhBcnJheVswXSA/PyAnJykgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICF0aGlzLmRyb3BTcGVjaWFsQ2hhcmFjdGVyc1xuICAgICAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHNwZWNpYWwgPSB2YWx1ZS5zcGxpdChsYXN0SW5kZXhBcnJheVswXSk7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gc3BlY2lhbFtzcGVjaWFsLmxlbmd0aCAtIDFdLmxlbmd0aCA9PT0gbGFzdEluZGV4QXJyYXkubGVuZ3RoIC0gMVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgID8gbnVsbFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogdGhpcy5fY3JlYXRlVmFsaWRhdGlvbkVycm9yKHZhbHVlKTtcbiAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgICgobGFzdEluZGV4QXJyYXkgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAhdGhpcy5fbWFza1NlcnZpY2Uuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhc3RJbmRleEFycmF5WzBdIGFzIHN0cmluZ1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICkpIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIWxhc3RJbmRleEFycmF5IHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuZHJvcFNwZWNpYWxDaGFyYWN0ZXJzKSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUubGVuZ3RoID49IGxlbmd0aCAtIDFcbiAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gbnVsbDtcbiAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0aGlzLl9jcmVhdGVWYWxpZGF0aW9uRXJyb3IodmFsdWUpO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tWYWx1ZS5pbmRleE9mKE1hc2tFeHByZXNzaW9uLlNZTUJPTF9TVEFSKSA9PT0gMSB8fFxuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tWYWx1ZS5pbmRleE9mKE1hc2tFeHByZXNzaW9uLlNZTUJPTF9RVUVTVElPTikgPT09IDFcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBudWxsO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIGlmICh2YWx1ZSkge1xuICAgICAgICAgICAgdGhpcy5tYXNrRmlsbGVkLmVtaXQoKTtcbiAgICAgICAgICAgIHJldHVybiBudWxsO1xuICAgICAgICB9XG4gICAgICAgIHJldHVybiBudWxsO1xuICAgIH1cblxuICAgIEBIb3N0TGlzdGVuZXIoJ3Bhc3RlJylcbiAgICBwdWJsaWMgb25QYXN0ZSgpIHtcbiAgICAgICAgdGhpcy5fanVzdFBhc3RlZCA9IHRydWU7XG4gICAgfVxuXG4gICAgQEhvc3RMaXN0ZW5lcignZm9jdXMnLCBbJyRldmVudCddKSBwdWJsaWMgb25Gb2N1cygpIHtcbiAgICAgICAgdGhpcy5faXNGb2N1c2VkID0gdHJ1ZTtcbiAgICB9XG5cbiAgICBASG9zdExpc3RlbmVyKCduZ01vZGVsQ2hhbmdlJywgWyckZXZlbnQnXSlcbiAgICBwdWJsaWMgb25Nb2RlbENoYW5nZSh2YWx1ZTogc3RyaW5nIHwgdW5kZWZpbmVkIHwgbnVsbCB8IG51bWJlcik6IHZvaWQge1xuICAgICAgICAvLyBvbiBmb3JtIHJlc2V0IHdlIG5lZWQgdG8gdXBkYXRlIHRoZSBhY3R1YWxWYWx1ZVxuICAgICAgICBpZiAoXG4gICAgICAgICAgICAodmFsdWUgPT09IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORyB8fCB2YWx1ZSA9PT0gbnVsbCB8fCB2YWx1ZSA9PT0gdW5kZWZpbmVkKSAmJlxuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWN0dWFsVmFsdWVcbiAgICAgICAgKSB7XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZSA9IHRoaXMuX21hc2tTZXJ2aWNlLmdldEFjdHVhbFZhbHVlKFxuICAgICAgICAgICAgICAgIE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgKTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIEBIb3N0TGlzdGVuZXIoJ2lucHV0JywgWyckZXZlbnQnXSlcbiAgICBwdWJsaWMgb25JbnB1dChlOiBDdXN0b21LZXlib2FyZEV2ZW50KTogdm9pZCB7XG4gICAgICAgIC8vIElmIElNRSBpcyBjb21wb3NpbmcgdGV4dCwgd2Ugd2FpdCBmb3IgdGhlIGNvbXBvc2VkIHRleHQuXG4gICAgICAgIGlmICh0aGlzLl9pc0NvbXBvc2luZykgcmV0dXJuO1xuICAgICAgICBjb25zdCBlbDogSFRNTElucHV0RWxlbWVudCA9IGUudGFyZ2V0IGFzIEhUTUxJbnB1dEVsZW1lbnQ7XG4gICAgICAgIGNvbnN0IHRyYW5zZm9ybWVkVmFsdWUgPSB0aGlzLl9tYXNrU2VydmljZS5pbnB1dFRyYW5zZm9ybUZuKGVsLnZhbHVlKTtcbiAgICAgICAgaWYgKGVsLnR5cGUgIT09ICdudW1iZXInKSB7XG4gICAgICAgICAgICBpZiAodHlwZW9mIHRyYW5zZm9ybWVkVmFsdWUgPT09ICdzdHJpbmcnIHx8IHR5cGVvZiB0cmFuc2Zvcm1lZFZhbHVlID09PSAnbnVtYmVyJykge1xuICAgICAgICAgICAgICAgIGVsLnZhbHVlID0gdHJhbnNmb3JtZWRWYWx1ZS50b1N0cmluZygpO1xuXG4gICAgICAgICAgICAgICAgdGhpcy5faW5wdXRWYWx1ZSA9IGVsLnZhbHVlO1xuICAgICAgICAgICAgICAgIHRoaXMuX3NldE1hc2soKTtcblxuICAgICAgICAgICAgICAgIGlmICghdGhpcy5fbWFza1ZhbHVlKSB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMub25DaGFuZ2UoZWwudmFsdWUpO1xuICAgICAgICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgbGV0IHBvc2l0aW9uOiBudW1iZXIgPVxuICAgICAgICAgICAgICAgICAgICBlbC5zZWxlY3Rpb25TdGFydCA9PT0gMVxuICAgICAgICAgICAgICAgICAgICAgICAgPyAoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKSArIHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeC5sZW5ndGhcbiAgICAgICAgICAgICAgICAgICAgICAgIDogKGVsLnNlbGVjdGlvblN0YXJ0IGFzIG51bWJlcik7XG5cbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuc2hvd01hc2tUeXBlZCAmJlxuICAgICAgICAgICAgICAgICAgICB0aGlzLmtlZXBDaGFyYWN0ZXJQb3NpdGlvbnMgJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UucGxhY2VIb2xkZXJDaGFyYWN0ZXIubGVuZ3RoID09PSAxXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0U3ltYm9sID0gZWwudmFsdWUuc2xpY2UocG9zaXRpb24gLSAxLCBwb3NpdGlvbik7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IHByZWZpeExlbmd0aCA9IHRoaXMucHJlZml4Lmxlbmd0aDtcbiAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hlY2tTeW1ib2xzOiBib29sZWFuID0gdGhpcy5fbWFza1NlcnZpY2UuX2NoZWNrU3ltYm9sTWFzayhcbiAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0U3ltYm9sLFxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0V4cHJlc3Npb25bcG9zaXRpb24gLSAxIC0gcHJlZml4TGVuZ3RoXSA/P1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgICAgICAgICApO1xuXG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoZWNrU3BlY2lhbENoYXJhY3RlcjogYm9vbGVhbiA9IHRoaXMuX21hc2tTZXJ2aWNlLl9jaGVja1N5bWJvbE1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFN5bWJvbCxcbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tFeHByZXNzaW9uW3Bvc2l0aW9uICsgMSAtIHByZWZpeExlbmd0aF0gPz9cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkdcbiAgICAgICAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgICAgICAgY29uc3Qgc2VsZWN0UmFuZ2VCYWNrc3BhY2U6IGJvb2xlYW4gPVxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uuc2VsU3RhcnQgPT09IHRoaXMuX21hc2tTZXJ2aWNlLnNlbEVuZDtcbiAgICAgICAgICAgICAgICAgICAgY29uc3Qgc2VsU3RhcnQgPSBOdW1iZXIodGhpcy5fbWFza1NlcnZpY2Uuc2VsU3RhcnQpIC0gcHJlZml4TGVuZ3RoID8/ICcnO1xuICAgICAgICAgICAgICAgICAgICBjb25zdCBzZWxFbmQgPSBOdW1iZXIodGhpcy5fbWFza1NlcnZpY2Uuc2VsRW5kKSAtIHByZWZpeExlbmd0aCA/PyAnJztcblxuICAgICAgICAgICAgICAgICAgICBpZiAodGhpcy5fY29kZSA9PT0gTWFza0V4cHJlc3Npb24uQkFDS1NQQUNFKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXNlbGVjdFJhbmdlQmFja3NwYWNlKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHRoaXMuX21hc2tTZXJ2aWNlLnNlbFN0YXJ0ID09PSBwcmVmaXhMZW5ndGgpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWN0dWFsVmFsdWUgPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5wcmVmaXggK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0lzU2hvd24uc2xpY2UoMCwgc2VsRW5kKSArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlLnNwbGl0KHRoaXMucHJlZml4KS5qb2luKCcnKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5zZWxTdGFydCA9PT1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0lzU2hvd24ubGVuZ3RoICsgcHJlZml4TGVuZ3RoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmFjdHVhbFZhbHVlID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX2lucHV0VmFsdWUgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0lzU2hvd24uc2xpY2Uoc2VsU3RhcnQsIHNlbEVuZCk7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWN0dWFsVmFsdWUgPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5wcmVmaXggK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5faW5wdXRWYWx1ZVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5zcGxpdCh0aGlzLnByZWZpeClcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuam9pbignJylcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuc2xpY2UoMCwgc2VsU3RhcnQpICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tJc1Nob3duLnNsaWNlKHNlbFN0YXJ0LCBzZWxFbmQpICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmFjdHVhbFZhbHVlLnNsaWNlKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlbEVuZCArIHByZWZpeExlbmd0aCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrSXNTaG93bi5sZW5ndGggKyBwcmVmaXhMZW5ndGhcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5zdWZmaXg7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAhdGhpcy5fbWFza1NlcnZpY2Uuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tFeHByZXNzaW9uLnNsaWNlKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zaXRpb24gLSB0aGlzLnByZWZpeC5sZW5ndGgsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiArIDEgLSB0aGlzLnByZWZpeC5sZW5ndGhcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICkgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWxlY3RSYW5nZUJhY2tzcGFjZVxuICAgICAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNlbFN0YXJ0ID09PSAxICYmIHRoaXMucHJlZml4KSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmFjdHVhbFZhbHVlID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMucHJlZml4ICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnBsYWNlSG9sZGVyQ2hhcmFjdGVyICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsLnZhbHVlXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLnNwbGl0KHRoaXMucHJlZml4KVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5qb2luKCcnKVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5zcGxpdCh0aGlzLnN1ZmZpeClcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuam9pbignJykgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5zdWZmaXg7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l0aW9uID0gcG9zaXRpb24gLSAxO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHBhcnQxID0gZWwudmFsdWUuc3Vic3RyaW5nKDAsIHBvc2l0aW9uKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgcGFydDIgPSBlbC52YWx1ZS5zdWJzdHJpbmcocG9zaXRpb24pO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJ0MSArIHRoaXMuX21hc2tTZXJ2aWNlLnBsYWNlSG9sZGVyQ2hhcmFjdGVyICsgcGFydDI7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIGlmICh0aGlzLl9jb2RlICE9PSBNYXNrRXhwcmVzc2lvbi5CQUNLU1BBQ0UpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIGlmICghY2hlY2tTeW1ib2xzICYmICFjaGVja1NwZWNpYWxDaGFyYWN0ZXIgJiYgc2VsZWN0UmFuZ2VCYWNrc3BhY2UpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiA9IE51bWJlcihlbC5zZWxlY3Rpb25TdGFydCkgLSAxO1xuICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5zcGVjaWFsQ2hhcmFjdGVycy5pbmNsdWRlcyhcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUuc2xpY2UocG9zaXRpb24sIHBvc2l0aW9uICsgMSlcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICApICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tTcGVjaWFsQ2hhcmFjdGVyICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIXRoaXMuX21hc2tTZXJ2aWNlLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbC52YWx1ZS5zbGljZShwb3NpdGlvbiArIDEsIHBvc2l0aW9uICsgMilcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICApXG4gICAgICAgICAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsLnZhbHVlLnNsaWNlKDAsIHBvc2l0aW9uIC0gMSkgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbC52YWx1ZS5zbGljZShwb3NpdGlvbiwgcG9zaXRpb24gKyAxKSArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0U3ltYm9sICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUuc2xpY2UocG9zaXRpb24gKyAyKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiA9IHBvc2l0aW9uICsgMTtcbiAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoY2hlY2tTeW1ib2xzKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVsLnZhbHVlLmxlbmd0aCA9PT0gMSAmJiBwb3NpdGlvbiA9PT0gMSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLnByZWZpeCArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFN5bWJvbCArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrSXNTaG93bi5zbGljZShcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tJc1Nob3duLmxlbmd0aFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKSArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLnN1ZmZpeDtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbC52YWx1ZS5zbGljZSgwLCBwb3NpdGlvbiAtIDEpICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0U3ltYm9sICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsLnZhbHVlXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLnNsaWNlKHBvc2l0aW9uICsgMSlcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuc3BsaXQodGhpcy5zdWZmaXgpXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLmpvaW4oJycpICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3VmZml4O1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5wcmVmaXggJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbC52YWx1ZS5sZW5ndGggPT09IDEgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiAtIHByZWZpeExlbmd0aCA9PT0gMSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLl9jaGVja1N5bWJvbE1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsLnZhbHVlLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbltwb3NpdGlvbiAtIDEgLSBwcmVmaXhMZW5ndGhdID8/XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkdcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICApXG4gICAgICAgICAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMucHJlZml4ICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrSXNTaG93bi5zbGljZShcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrSXNTaG93bi5sZW5ndGhcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKSArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3VmZml4O1xuICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgbGV0IGNhcmV0U2hpZnQgPSAwO1xuICAgICAgICAgICAgICAgIGxldCBiYWNrc3BhY2VTaGlmdCA9IGZhbHNlO1xuICAgICAgICAgICAgICAgIGlmICh0aGlzLl9jb2RlID09PSBNYXNrRXhwcmVzc2lvbi5ERUxFVEUgJiYgTWFza0V4cHJlc3Npb24uU0VQQVJBVE9SKSB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmRlbGV0ZWRTcGVjaWFsQ2hhcmFjdGVyID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlLmxlbmd0aCA+PSB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbi5sZW5ndGggLSAxICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX2NvZGUgIT09IE1hc2tFeHByZXNzaW9uLkJBQ0tTUEFDRSAmJlxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiA9PT0gTWFza0V4cHJlc3Npb24uREFZU19NT05USFNfWUVBUlMgJiZcbiAgICAgICAgICAgICAgICAgICAgcG9zaXRpb24gPCAxMFxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICBjb25zdCBpbnB1dFN5bWJvbCA9IHRoaXMuX2lucHV0VmFsdWUuc2xpY2UocG9zaXRpb24gLSAxLCBwb3NpdGlvbik7XG4gICAgICAgICAgICAgICAgICAgIGVsLnZhbHVlID1cbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX2lucHV0VmFsdWUuc2xpY2UoMCwgcG9zaXRpb24gLSAxKSArXG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFN5bWJvbCArXG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlLnNsaWNlKHBvc2l0aW9uICsgMSk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0V4cHJlc3Npb24gPT09IE1hc2tFeHByZXNzaW9uLkRBWVNfTU9OVEhTX1lFQVJTICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMubGVhZFplcm9EYXRlVGltZVxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgICAgICAocG9zaXRpb24gPCAzICYmIE51bWJlcihlbC52YWx1ZSkgPiAzMSAmJiBOdW1iZXIoZWwudmFsdWUpIDwgNDApIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAocG9zaXRpb24gPT09IDUgJiYgTnVtYmVyKGVsLnZhbHVlLnNsaWNlKDMsIDUpKSA+IDEyKVxuICAgICAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l0aW9uID0gcG9zaXRpb24gKyAyO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiA9PT0gTWFza0V4cHJlc3Npb24uSE9VUlNfTUlOVVRFU19TRUNPTkRTICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuYXBtXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIGlmICh0aGlzLl9qdXN0UGFzdGVkICYmIGVsLnZhbHVlLnNsaWNlKDAsIDIpID09PSBNYXNrRXhwcmVzc2lvbi5ET1VCTEVfWkVSTykge1xuICAgICAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUgPSBlbC52YWx1ZS5zbGljZSgxLCAyKSArIGVsLnZhbHVlLnNsaWNlKDIsIGVsLnZhbHVlLmxlbmd0aCk7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUgPVxuICAgICAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUgPT09IE1hc2tFeHByZXNzaW9uLkRPVUJMRV9aRVJPXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgPyBNYXNrRXhwcmVzc2lvbi5OVU1CRVJfWkVST1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogZWwudmFsdWU7XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYXBwbHlWYWx1ZUNoYW5nZXMoXG4gICAgICAgICAgICAgICAgICAgIHBvc2l0aW9uLFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9qdXN0UGFzdGVkLFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9jb2RlID09PSBNYXNrRXhwcmVzc2lvbi5CQUNLU1BBQ0UgfHwgdGhpcy5fY29kZSA9PT0gTWFza0V4cHJlc3Npb24uREVMRVRFLFxuICAgICAgICAgICAgICAgICAgICAoc2hpZnQ6IG51bWJlciwgX2JhY2tzcGFjZVNoaWZ0OiBib29sZWFuKSA9PiB7XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9qdXN0UGFzdGVkID0gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgICAgICBjYXJldFNoaWZ0ID0gc2hpZnQ7XG4gICAgICAgICAgICAgICAgICAgICAgICBiYWNrc3BhY2VTaGlmdCA9IF9iYWNrc3BhY2VTaGlmdDtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgICAgLy8gb25seSBzZXQgdGhlIHNlbGVjdGlvbiBpZiB0aGUgZWxlbWVudCBpcyBhY3RpdmVcbiAgICAgICAgICAgICAgICBpZiAodGhpcy5fZ2V0QWN0aXZlRWxlbWVudCgpICE9PSBlbCkge1xuICAgICAgICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgaWYgKHRoaXMuX21hc2tTZXJ2aWNlLnBsdXNPbmVQb3NpdGlvbikge1xuICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiA9IHBvc2l0aW9uICsgMTtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UucGx1c09uZVBvc2l0aW9uID0gZmFsc2U7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIC8vIHVwZGF0ZSBwb3NpdGlvbiBhZnRlciBhcHBseVZhbHVlQ2hhbmdlcyB0byBwcmV2ZW50IGN1cnNvciBvbiB3cm9uZyBwb3NpdGlvbiB3aGVuIGl0IGhhcyBhbiBhcnJheSBvZiBtYXNrRXhwcmVzc2lvblxuICAgICAgICAgICAgICAgIGlmICh0aGlzLl9tYXNrRXhwcmVzc2lvbkFycmF5Lmxlbmd0aCkge1xuICAgICAgICAgICAgICAgICAgICBpZiAodGhpcy5fY29kZSA9PT0gTWFza0V4cHJlc3Npb24uQkFDS1NQQUNFKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiA9IHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5faW5wdXRWYWx1ZS5zbGljZShwb3NpdGlvbiAtIDEsIHBvc2l0aW9uKVxuICAgICAgICAgICAgICAgICAgICAgICAgKVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgID8gcG9zaXRpb24gLSAxXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBwb3NpdGlvbjtcbiAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l0aW9uID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbC5zZWxlY3Rpb25TdGFydCA9PT0gMVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA/IChlbC5zZWxlY3Rpb25TdGFydCBhcyBudW1iZXIpICsgdGhpcy5fbWFza1NlcnZpY2UucHJlZml4Lmxlbmd0aFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IChlbC5zZWxlY3Rpb25TdGFydCBhcyBudW1iZXIpO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHRoaXMuX3Bvc2l0aW9uID1cbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fcG9zaXRpb24gPT09IDEgJiYgdGhpcy5faW5wdXRWYWx1ZS5sZW5ndGggPT09IDEgPyBudWxsIDogdGhpcy5fcG9zaXRpb247XG4gICAgICAgICAgICAgICAgbGV0IHBvc2l0aW9uVG9BcHBseTogbnVtYmVyID0gdGhpcy5fcG9zaXRpb25cbiAgICAgICAgICAgICAgICAgICAgPyB0aGlzLl9pbnB1dFZhbHVlLmxlbmd0aCArIHBvc2l0aW9uICsgY2FyZXRTaGlmdFxuICAgICAgICAgICAgICAgICAgICA6IHBvc2l0aW9uICtcbiAgICAgICAgICAgICAgICAgICAgICAodGhpcy5fY29kZSA9PT0gTWFza0V4cHJlc3Npb24uQkFDS1NQQUNFICYmICFiYWNrc3BhY2VTaGlmdCA/IDAgOiBjYXJldFNoaWZ0KTtcbiAgICAgICAgICAgICAgICBpZiAocG9zaXRpb25Ub0FwcGx5ID4gdGhpcy5fZ2V0QWN0dWFsSW5wdXRMZW5ndGgoKSkge1xuICAgICAgICAgICAgICAgICAgICBwb3NpdGlvblRvQXBwbHkgPVxuICAgICAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUgPT09IHRoaXMuX21hc2tTZXJ2aWNlLmRlY2ltYWxNYXJrZXIgJiYgZWwudmFsdWUubGVuZ3RoID09PSAxXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgPyB0aGlzLl9nZXRBY3R1YWxJbnB1dExlbmd0aCgpICsgMVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogdGhpcy5fZ2V0QWN0dWFsSW5wdXRMZW5ndGgoKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgaWYgKHBvc2l0aW9uVG9BcHBseSA8IDApIHtcbiAgICAgICAgICAgICAgICAgICAgcG9zaXRpb25Ub0FwcGx5ID0gMDtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgZWwuc2V0U2VsZWN0aW9uUmFuZ2UocG9zaXRpb25Ub0FwcGx5LCBwb3NpdGlvblRvQXBwbHkpO1xuICAgICAgICAgICAgICAgIHRoaXMuX3Bvc2l0aW9uID0gbnVsbDtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgY29uc29sZS53YXJuKFxuICAgICAgICAgICAgICAgICAgICAnTmd4LW1hc2sgd3JpdGVWYWx1ZSB3b3JrIHdpdGggc3RyaW5nIHwgbnVtYmVyLCB5b3VyIGN1cnJlbnQgdmFsdWU6JyxcbiAgICAgICAgICAgICAgICAgICAgdHlwZW9mIHRyYW5zZm9ybWVkVmFsdWVcbiAgICAgICAgICAgICAgICApO1xuICAgICAgICAgICAgfVxuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgaWYgKCF0aGlzLl9tYXNrVmFsdWUpIHtcbiAgICAgICAgICAgICAgICB0aGlzLm9uQ2hhbmdlKGVsLnZhbHVlKTtcbiAgICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hcHBseVZhbHVlQ2hhbmdlcyhcbiAgICAgICAgICAgICAgICBlbC52YWx1ZS5sZW5ndGgsXG4gICAgICAgICAgICAgICAgdGhpcy5fanVzdFBhc3RlZCxcbiAgICAgICAgICAgICAgICB0aGlzLl9jb2RlID09PSBNYXNrRXhwcmVzc2lvbi5CQUNLU1BBQ0UgfHwgdGhpcy5fY29kZSA9PT0gTWFza0V4cHJlc3Npb24uREVMRVRFXG4gICAgICAgICAgICApO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgLy8gSU1FIHN0YXJ0c1xuICAgIEBIb3N0TGlzdGVuZXIoJ2NvbXBvc2l0aW9uc3RhcnQnLCBbJyRldmVudCddKVxuICAgIHB1YmxpYyBvbkNvbXBvc2l0aW9uU3RhcnQoKTogdm9pZCB7XG4gICAgICAgIHRoaXMuX2lzQ29tcG9zaW5nID0gdHJ1ZTtcbiAgICB9XG5cbiAgICAvLyBJTUUgY29tcGxldGVzXG4gICAgQEhvc3RMaXN0ZW5lcignY29tcG9zaXRpb25lbmQnLCBbJyRldmVudCddKVxuICAgIHB1YmxpYyBvbkNvbXBvc2l0aW9uRW5kKGU6IEN1c3RvbUtleWJvYXJkRXZlbnQpOiB2b2lkIHtcbiAgICAgICAgdGhpcy5faXNDb21wb3NpbmcgPSBmYWxzZTtcbiAgICAgICAgdGhpcy5fanVzdFBhc3RlZCA9IHRydWU7XG4gICAgICAgIHRoaXMub25JbnB1dChlKTtcbiAgICB9XG5cbiAgICBASG9zdExpc3RlbmVyKCdibHVyJywgWyckZXZlbnQnXSlcbiAgICBwdWJsaWMgb25CbHVyKGU6IEN1c3RvbUtleWJvYXJkRXZlbnQpOiB2b2lkIHtcbiAgICAgICAgaWYgKHRoaXMuX21hc2tWYWx1ZSkge1xuICAgICAgICAgICAgY29uc3QgZWw6IEhUTUxJbnB1dEVsZW1lbnQgPSBlLnRhcmdldCBhcyBIVE1MSW5wdXRFbGVtZW50O1xuICAgICAgICAgICAgaWYgKHRoaXMubGVhZFplcm8gJiYgZWwudmFsdWUubGVuZ3RoID4gMCAmJiB0eXBlb2YgdGhpcy5kZWNpbWFsTWFya2VyID09PSAnc3RyaW5nJykge1xuICAgICAgICAgICAgICAgIGNvbnN0IG1hc2tFeHByZXNzaW9uID0gdGhpcy5fbWFza1NlcnZpY2UubWFza0V4cHJlc3Npb247XG4gICAgICAgICAgICAgICAgY29uc3QgcHJlY2lzaW9uID0gTnVtYmVyKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbi5zbGljZShcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uLmxlbmd0aCAtIDEsXG4gICAgICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbi5sZW5ndGhcbiAgICAgICAgICAgICAgICAgICAgKVxuICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgICAgaWYgKHByZWNpc2lvbiA+IDEpIHtcbiAgICAgICAgICAgICAgICAgICAgZWwudmFsdWUgPSB0aGlzLnN1ZmZpeCA/IGVsLnZhbHVlLnNwbGl0KHRoaXMuc3VmZml4KS5qb2luKCcnKSA6IGVsLnZhbHVlO1xuICAgICAgICAgICAgICAgICAgICBjb25zdCBkZWNpbWFsUGFydCA9IGVsLnZhbHVlLnNwbGl0KHRoaXMuZGVjaW1hbE1hcmtlcilbMV0gYXMgc3RyaW5nO1xuICAgICAgICAgICAgICAgICAgICBlbC52YWx1ZSA9IGVsLnZhbHVlLmluY2x1ZGVzKHRoaXMuZGVjaW1hbE1hcmtlcilcbiAgICAgICAgICAgICAgICAgICAgICAgID8gZWwudmFsdWUgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICBNYXNrRXhwcmVzc2lvbi5OVU1CRVJfWkVSTy5yZXBlYXQocHJlY2lzaW9uIC0gZGVjaW1hbFBhcnQubGVuZ3RoKSArXG4gICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3VmZml4XG4gICAgICAgICAgICAgICAgICAgICAgICA6IGVsLnZhbHVlICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5kZWNpbWFsTWFya2VyICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgTWFza0V4cHJlc3Npb24uTlVNQkVSX1pFUk8ucmVwZWF0KHByZWNpc2lvbikgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLnN1ZmZpeDtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWN0dWFsVmFsdWUgPSBlbC52YWx1ZTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5jbGVhcklmTm90TWF0Y2hGbigpO1xuICAgICAgICB9XG4gICAgICAgIHRoaXMuX2lzRm9jdXNlZCA9IGZhbHNlO1xuICAgICAgICB0aGlzLm9uVG91Y2goKTtcbiAgICB9XG5cbiAgICBASG9zdExpc3RlbmVyKCdjbGljaycsIFsnJGV2ZW50J10pXG4gICAgcHVibGljIG9uQ2xpY2soZTogTW91c2VFdmVudCB8IEN1c3RvbUtleWJvYXJkRXZlbnQpOiB2b2lkIHtcbiAgICAgICAgaWYgKCF0aGlzLl9tYXNrVmFsdWUpIHtcbiAgICAgICAgICAgIHJldHVybjtcbiAgICAgICAgfVxuXG4gICAgICAgIGNvbnN0IGVsOiBIVE1MSW5wdXRFbGVtZW50ID0gZS50YXJnZXQgYXMgSFRNTElucHV0RWxlbWVudDtcbiAgICAgICAgY29uc3QgcG9zU3RhcnQgPSAwO1xuICAgICAgICBjb25zdCBwb3NFbmQgPSAwO1xuXG4gICAgICAgIGlmIChcbiAgICAgICAgICAgIGVsICE9PSBudWxsICYmXG4gICAgICAgICAgICBlbC5zZWxlY3Rpb25TdGFydCAhPT0gbnVsbCAmJlxuICAgICAgICAgICAgZWwuc2VsZWN0aW9uU3RhcnQgPT09IGVsLnNlbGVjdGlvbkVuZCAmJlxuICAgICAgICAgICAgZWwuc2VsZWN0aW9uU3RhcnQgPiB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXgubGVuZ3RoICYmXG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmVcbiAgICAgICAgICAgIChlIGFzIGFueSkua2V5Q29kZSAhPT0gMzhcbiAgICAgICAgKSB7XG4gICAgICAgICAgICBpZiAodGhpcy5fbWFza1NlcnZpY2Uuc2hvd01hc2tUeXBlZCAmJiAhdGhpcy5rZWVwQ2hhcmFjdGVyUG9zaXRpb25zKSB7XG4gICAgICAgICAgICAgICAgLy8gV2UgYXJlIHNob3dpbmcgdGhlIG1hc2sgaW4gdGhlIGlucHV0XG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0lzU2hvd24gPSB0aGlzLl9tYXNrU2VydmljZS5zaG93TWFza0luSW5wdXQoKTtcbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIGVsLnNldFNlbGVjdGlvblJhbmdlICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeCArIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tJc1Nob3duID09PSBlbC52YWx1ZVxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAvLyB0aGUgaW5wdXQgT05MWSBjb250YWlucyB0aGUgbWFzaywgc28gcG9zaXRpb24gdGhlIGN1cnNvciBhdCB0aGUgc3RhcnRcbiAgICAgICAgICAgICAgICAgICAgZWwuZm9jdXMoKTtcbiAgICAgICAgICAgICAgICAgICAgZWwuc2V0U2VsZWN0aW9uUmFuZ2UocG9zU3RhcnQsIHBvc0VuZCk7XG4gICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgLy8gdGhlIGlucHV0IGNvbnRhaW5zIHNvbWUgY2hhcmFjdGVycyBhbHJlYWR5XG4gICAgICAgICAgICAgICAgICAgIGlmIChlbC5zZWxlY3Rpb25TdGFydCA+IHRoaXMuX21hc2tTZXJ2aWNlLmFjdHVhbFZhbHVlLmxlbmd0aCkge1xuICAgICAgICAgICAgICAgICAgICAgICAgLy8gaWYgdGhlIHVzZXIgY2xpY2tlZCBiZXlvbmQgb3VyIHZhbHVlJ3MgbGVuZ3RoLCBwb3NpdGlvbiB0aGUgY3Vyc29yIGF0IHRoZSBlbmQgb2Ygb3VyIHZhbHVlXG4gICAgICAgICAgICAgICAgICAgICAgICBlbC5zZXRTZWxlY3Rpb25SYW5nZShcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZS5sZW5ndGgsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWN0dWFsVmFsdWUubGVuZ3RoXG4gICAgICAgICAgICAgICAgICAgICAgICApO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIGNvbnN0IG5leHRWYWx1ZTogc3RyaW5nIHwgbnVsbCA9XG4gICAgICAgICAgICBlbCAmJlxuICAgICAgICAgICAgKGVsLnZhbHVlID09PSB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXhcbiAgICAgICAgICAgICAgICA/IHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeCArIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tJc1Nob3duXG4gICAgICAgICAgICAgICAgOiBlbC52YWx1ZSk7XG5cbiAgICAgICAgLyoqIEZpeCBvZiBjdXJzb3IgcG9zaXRpb24ganVtcGluZyB0byBlbmQgaW4gbW9zdCBicm93c2VycyBubyBtYXR0ZXIgd2hlcmUgY3Vyc29yIGlzIGluc2VydGVkIG9uRm9jdXMgKi9cbiAgICAgICAgaWYgKGVsICYmIGVsLnZhbHVlICE9PSBuZXh0VmFsdWUpIHtcbiAgICAgICAgICAgIGVsLnZhbHVlID0gbmV4dFZhbHVlO1xuICAgICAgICB9XG4gICAgICAgIC8qKiBmaXggb2YgY3Vyc29yIHBvc2l0aW9uIHdpdGggcHJlZml4IHdoZW4gbW91c2UgY2xpY2sgb2NjdXIgKi9cbiAgICAgICAgaWYgKFxuICAgICAgICAgICAgZWwgJiZcbiAgICAgICAgICAgIGVsLnR5cGUgIT09ICdudW1iZXInICYmXG4gICAgICAgICAgICAoKGVsLnNlbGVjdGlvblN0YXJ0IGFzIG51bWJlcikgfHwgKGVsLnNlbGVjdGlvbkVuZCBhcyBudW1iZXIpKSA8PVxuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeC5sZW5ndGhcbiAgICAgICAgKSB7XG4gICAgICAgICAgICBlbC5zZWxlY3Rpb25TdGFydCA9IHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeC5sZW5ndGg7XG4gICAgICAgICAgICByZXR1cm47XG4gICAgICAgIH1cbiAgICAgICAgLyoqIHNlbGVjdCBvbmx5IGluc2VydGVkIHRleHQgKi9cbiAgICAgICAgaWYgKGVsICYmIChlbC5zZWxlY3Rpb25FbmQgYXMgbnVtYmVyKSA+IHRoaXMuX2dldEFjdHVhbElucHV0TGVuZ3RoKCkpIHtcbiAgICAgICAgICAgIGVsLnNlbGVjdGlvbkVuZCA9IHRoaXMuX2dldEFjdHVhbElucHV0TGVuZ3RoKCk7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgY29tcGxleGl0eVxuICAgIEBIb3N0TGlzdGVuZXIoJ2tleWRvd24nLCBbJyRldmVudCddKVxuICAgIHB1YmxpYyBvbktleURvd24oZTogQ3VzdG9tS2V5Ym9hcmRFdmVudCk6IHZvaWQge1xuICAgICAgICBpZiAoIXRoaXMuX21hc2tWYWx1ZSkge1xuICAgICAgICAgICAgcmV0dXJuO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKHRoaXMuX2lzQ29tcG9zaW5nKSB7XG4gICAgICAgICAgICAvLyBVc2VyIGZpbmFsaXplIHRoZWlyIGNob2ljZSBmcm9tIElNRSBjb21wb3NpdGlvbiwgc28gdHJpZ2dlciBvbklucHV0KCkgZm9yIHRoZSBjb21wb3NlZCB0ZXh0LlxuICAgICAgICAgICAgaWYgKGUua2V5ID09PSAnRW50ZXInKSB0aGlzLm9uQ29tcG9zaXRpb25FbmQoZSk7XG4gICAgICAgICAgICByZXR1cm47XG4gICAgICAgIH1cblxuICAgICAgICB0aGlzLl9jb2RlID0gZS5jb2RlID8gZS5jb2RlIDogZS5rZXk7XG4gICAgICAgIGNvbnN0IGVsOiBIVE1MSW5wdXRFbGVtZW50ID0gZS50YXJnZXQgYXMgSFRNTElucHV0RWxlbWVudDtcbiAgICAgICAgdGhpcy5faW5wdXRWYWx1ZSA9IGVsLnZhbHVlO1xuICAgICAgICB0aGlzLl9zZXRNYXNrKCk7XG5cbiAgICAgICAgaWYgKGVsLnR5cGUgIT09ICdudW1iZXInKSB7XG4gICAgICAgICAgICBpZiAoZS5rZXkgPT09IE1hc2tFeHByZXNzaW9uLkFSUk9XX1VQKSB7XG4gICAgICAgICAgICAgICAgZS5wcmV2ZW50RGVmYXVsdCgpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgIGUua2V5ID09PSBNYXNrRXhwcmVzc2lvbi5BUlJPV19MRUZUIHx8XG4gICAgICAgICAgICAgICAgZS5rZXkgPT09IE1hc2tFeHByZXNzaW9uLkJBQ0tTUEFDRSB8fFxuICAgICAgICAgICAgICAgIGUua2V5ID09PSBNYXNrRXhwcmVzc2lvbi5ERUxFVEVcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIGlmIChlLmtleSA9PT0gTWFza0V4cHJlc3Npb24uQkFDS1NQQUNFICYmIGVsLnZhbHVlLmxlbmd0aCA9PT0gMCkge1xuICAgICAgICAgICAgICAgICAgICBlbC5zZWxlY3Rpb25TdGFydCA9IGVsLnNlbGVjdGlvbkVuZDtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgaWYgKGUua2V5ID09PSBNYXNrRXhwcmVzc2lvbi5CQUNLU1BBQ0UgJiYgKGVsLnNlbGVjdGlvblN0YXJ0IGFzIG51bWJlcikgIT09IDApIHtcbiAgICAgICAgICAgICAgICAgICAgLy8gSWYgc3BlY2lhbENoYXJzIGlzIGZhbHNlLCAoc2hvdWxkbid0IGV2ZXIgaGFwcGVuKSB0aGVuIHNldCB0byB0aGUgZGVmYXVsdHNcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5zcGVjaWFsQ2hhcmFjdGVycyA9IHRoaXMuc3BlY2lhbENoYXJhY3RlcnM/Lmxlbmd0aFxuICAgICAgICAgICAgICAgICAgICAgICAgPyB0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzXG4gICAgICAgICAgICAgICAgICAgICAgICA6IHRoaXMuX2NvbmZpZy5zcGVjaWFsQ2hhcmFjdGVycztcbiAgICAgICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5wcmVmaXgubGVuZ3RoID4gMSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgKGVsLnNlbGVjdGlvblN0YXJ0IGFzIG51bWJlcikgPD0gdGhpcy5wcmVmaXgubGVuZ3RoXG4gICAgICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgZWwuc2V0U2VsZWN0aW9uUmFuZ2UodGhpcy5wcmVmaXgubGVuZ3RoLCBlbC5zZWxlY3Rpb25FbmQpO1xuICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX2lucHV0VmFsdWUubGVuZ3RoICE9PSAoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIChlbC5zZWxlY3Rpb25TdGFydCBhcyBudW1iZXIpICE9PSAxXG4gICAgICAgICAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aGlsZSAoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5faW5wdXRWYWx1ZVsoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKSAtIDFdID8/XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICApLnRvU3RyaW5nKClcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKHRoaXMucHJlZml4Lmxlbmd0aCA+PSAxICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKSA+IHRoaXMucHJlZml4Lmxlbmd0aCkgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMucHJlZml4Lmxlbmd0aCA9PT0gMClcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWwuc2V0U2VsZWN0aW9uUmFuZ2UoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKSAtIDEsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbC5zZWxlY3Rpb25FbmRcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgdGhpcy5jaGVja1NlbGVjdGlvbk9uRGVsZXRpb24oZWwpO1xuICAgICAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UucHJlZml4Lmxlbmd0aCAmJlxuICAgICAgICAgICAgICAgICAgICAoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKSA8PSB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXgubGVuZ3RoICYmXG4gICAgICAgICAgICAgICAgICAgIChlbC5zZWxlY3Rpb25FbmQgYXMgbnVtYmVyKSA8PSB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXgubGVuZ3RoXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIGUucHJldmVudERlZmF1bHQoKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgY29uc3QgY3Vyc29yU3RhcnQ6IG51bWJlciB8IG51bGwgPSBlbC5zZWxlY3Rpb25TdGFydDtcbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIGUua2V5ID09PSBNYXNrRXhwcmVzc2lvbi5CQUNLU1BBQ0UgJiZcbiAgICAgICAgICAgICAgICAgICAgIWVsLnJlYWRPbmx5ICYmXG4gICAgICAgICAgICAgICAgICAgIGN1cnNvclN0YXJ0ID09PSAwICYmXG4gICAgICAgICAgICAgICAgICAgIGVsLnNlbGVjdGlvbkVuZCA9PT0gZWwudmFsdWUubGVuZ3RoICYmXG4gICAgICAgICAgICAgICAgICAgIGVsLnZhbHVlLmxlbmd0aCAhPT0gMFxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICB0aGlzLl9wb3NpdGlvbiA9IHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeCA/IHRoaXMuX21hc2tTZXJ2aWNlLnByZWZpeC5sZW5ndGggOiAwO1xuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hcHBseU1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXgsXG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbixcbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX3Bvc2l0aW9uXG4gICAgICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICEhdGhpcy5zdWZmaXggJiZcbiAgICAgICAgICAgICAgICB0aGlzLnN1ZmZpeC5sZW5ndGggPiAxICYmXG4gICAgICAgICAgICAgICAgdGhpcy5faW5wdXRWYWx1ZS5sZW5ndGggLSB0aGlzLnN1ZmZpeC5sZW5ndGggPCAoZWwuc2VsZWN0aW9uU3RhcnQgYXMgbnVtYmVyKVxuICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgZWwuc2V0U2VsZWN0aW9uUmFuZ2UoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX2lucHV0VmFsdWUubGVuZ3RoIC0gdGhpcy5zdWZmaXgubGVuZ3RoLFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlLmxlbmd0aFxuICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgIChlLmNvZGUgPT09ICdLZXlBJyAmJiBlLmN0cmxLZXkpIHx8XG4gICAgICAgICAgICAgICAgKGUuY29kZSA9PT0gJ0tleUEnICYmIGUubWV0YUtleSkgLy8gQ21kICsgQSAoTWFjKVxuICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgZWwuc2V0U2VsZWN0aW9uUmFuZ2UoMCwgdGhpcy5fZ2V0QWN0dWFsSW5wdXRMZW5ndGgoKSk7XG4gICAgICAgICAgICAgICAgZS5wcmV2ZW50RGVmYXVsdCgpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uuc2VsU3RhcnQgPSBlbC5zZWxlY3Rpb25TdGFydDtcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLnNlbEVuZCA9IGVsLnNlbGVjdGlvbkVuZDtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIC8qKiBJdCB3cml0ZXMgdGhlIHZhbHVlIGluIHRoZSBpbnB1dCAqL1xuICAgIHB1YmxpYyBhc3luYyB3cml0ZVZhbHVlKGNvbnRyb2xWYWx1ZTogdW5rbm93bik6IFByb21pc2U8dm9pZD4ge1xuICAgICAgICBpZiAodHlwZW9mIGNvbnRyb2xWYWx1ZSA9PT0gJ29iamVjdCcgJiYgY29udHJvbFZhbHVlICE9PSBudWxsICYmICd2YWx1ZScgaW4gY29udHJvbFZhbHVlKSB7XG4gICAgICAgICAgICBpZiAoJ2Rpc2FibGUnIGluIGNvbnRyb2xWYWx1ZSkge1xuICAgICAgICAgICAgICAgIHRoaXMuc2V0RGlzYWJsZWRTdGF0ZShCb29sZWFuKGNvbnRyb2xWYWx1ZS5kaXNhYmxlKSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgIGNvbnRyb2xWYWx1ZSA9IGNvbnRyb2xWYWx1ZS52YWx1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoY29udHJvbFZhbHVlICE9PSBudWxsKSB7XG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgIGNvbnRyb2xWYWx1ZSA9IHRoaXMuaW5wdXRUcmFuc2Zvcm1GblxuICAgICAgICAgICAgICAgID8gdGhpcy5pbnB1dFRyYW5zZm9ybUZuKGNvbnRyb2xWYWx1ZSlcbiAgICAgICAgICAgICAgICA6IGNvbnRyb2xWYWx1ZTtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmIChcbiAgICAgICAgICAgIHR5cGVvZiBjb250cm9sVmFsdWUgPT09ICdzdHJpbmcnIHx8XG4gICAgICAgICAgICB0eXBlb2YgY29udHJvbFZhbHVlID09PSAnbnVtYmVyJyB8fFxuICAgICAgICAgICAgY29udHJvbFZhbHVlID09PSBudWxsIHx8XG4gICAgICAgICAgICBjb250cm9sVmFsdWUgPT09IHVuZGVmaW5lZFxuICAgICAgICApIHtcbiAgICAgICAgICAgIGlmIChjb250cm9sVmFsdWUgPT09IG51bGwgfHwgY29udHJvbFZhbHVlID09PSB1bmRlZmluZWQgfHwgY29udHJvbFZhbHVlID09PSAnJykge1xuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLl9jdXJyZW50VmFsdWUgPSAnJztcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5fcHJldmlvdXNWYWx1ZSA9ICcnO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICBsZXQgaW5wdXRWYWx1ZTogc3RyaW5nIHwgbnVtYmVyIHwgbnVsbCB8IHVuZGVmaW5lZCA9IGNvbnRyb2xWYWx1ZTtcbiAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICB0eXBlb2YgaW5wdXRWYWx1ZSA9PT0gJ251bWJlcicgfHxcbiAgICAgICAgICAgICAgICB0aGlzLl9tYXNrVmFsdWUuc3RhcnRzV2l0aChNYXNrRXhwcmVzc2lvbi5TRVBBUkFUT1IpXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICBpbnB1dFZhbHVlID0gU3RyaW5nKGlucHV0VmFsdWUpO1xuICAgICAgICAgICAgICAgIGNvbnN0IGxvY2FsZURlY2ltYWxNYXJrZXIgPSB0aGlzLl9tYXNrU2VydmljZS5jdXJyZW50TG9jYWxlRGVjaW1hbE1hcmtlcigpO1xuICAgICAgICAgICAgICAgIGlmICghQXJyYXkuaXNBcnJheSh0aGlzLl9tYXNrU2VydmljZS5kZWNpbWFsTWFya2VyKSkge1xuICAgICAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5kZWNpbWFsTWFya2VyICE9PSBsb2NhbGVEZWNpbWFsTWFya2VyXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgPyBpbnB1dFZhbHVlLnJlcGxhY2UoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9jYWxlRGVjaW1hbE1hcmtlcixcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5kZWNpbWFsTWFya2VyXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICApXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBpbnB1dFZhbHVlO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmxlYWRaZXJvICYmXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5tYXNrRXhwcmVzc2lvbiAmJlxuICAgICAgICAgICAgICAgICAgICB0aGlzLmRyb3BTcGVjaWFsQ2hhcmFjdGVycyAhPT0gZmFsc2VcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPSB0aGlzLl9tYXNrU2VydmljZS5fY2hlY2tQcmVjaXNpb24oXG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbixcbiAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgYXMgc3RyaW5nXG4gICAgICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIGlmICh0aGlzLl9tYXNrU2VydmljZS5kZWNpbWFsTWFya2VyID09PSBNYXNrRXhwcmVzc2lvbi5DT01NQSkge1xuICAgICAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IGlucHV0VmFsdWVcbiAgICAgICAgICAgICAgICAgICAgICAgIC50b1N0cmluZygpXG4gICAgICAgICAgICAgICAgICAgICAgICAucmVwbGFjZShNYXNrRXhwcmVzc2lvbi5ET1QsIE1hc2tFeHByZXNzaW9uLkNPTU1BKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgaWYgKHRoaXMubWFza0V4cHJlc3Npb24/LnN0YXJ0c1dpdGgoTWFza0V4cHJlc3Npb24uU0VQQVJBVE9SKSAmJiB0aGlzLmxlYWRaZXJvKSB7XG4gICAgICAgICAgICAgICAgICAgIHJlcXVlc3RBbmltYXRpb25GcmFtZSgoKSA9PiB7XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hcHBseU1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZT8udG9TdHJpbmcoKSA/PyAnJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvblxuICAgICAgICAgICAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmlzTnVtYmVyVmFsdWUgPSB0cnVlO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICBpZiAodHlwZW9mIGlucHV0VmFsdWUgIT09ICdzdHJpbmcnKSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9ICcnO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlID0gaW5wdXRWYWx1ZTtcbiAgICAgICAgICAgIHRoaXMuX3NldE1hc2soKTtcblxuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgIChpbnB1dFZhbHVlICYmIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tFeHByZXNzaW9uKSB8fFxuICAgICAgICAgICAgICAgICh0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiAmJlxuICAgICAgICAgICAgICAgICAgICAodGhpcy5fbWFza1NlcnZpY2UucHJlZml4IHx8IHRoaXMuX21hc2tTZXJ2aWNlLnNob3dNYXNrVHlwZWQpKVxuICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgLy8gTGV0IHRoZSBzZXJ2aWNlIHdlIGtub3cgd2UgYXJlIHdyaXRpbmcgdmFsdWUgc28gdGhhdCB0cmlnZ2VyaW5nIG9uQ2hhbmdlIGZ1bmN0aW9uIHdvbid0IGhhcHBlbiBkdXJpbmcgYXBwbHlNYXNrXG4gICAgICAgICAgICAgICAgdHlwZW9mIHRoaXMuaW5wdXRUcmFuc2Zvcm1GbiAhPT0gJ2Z1bmN0aW9uJ1xuICAgICAgICAgICAgICAgICAgICA/ICh0aGlzLl9tYXNrU2VydmljZS53cml0aW5nVmFsdWUgPSB0cnVlKVxuICAgICAgICAgICAgICAgICAgICA6ICcnO1xuICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmZvcm1FbGVtZW50UHJvcGVydHkgPSBbXG4gICAgICAgICAgICAgICAgICAgICd2YWx1ZScsXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmFwcGx5TWFzayhpbnB1dFZhbHVlLCB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiksXG4gICAgICAgICAgICAgICAgXTtcbiAgICAgICAgICAgICAgICAvLyBMZXQgdGhlIHNlcnZpY2Uga25vdyB3ZSd2ZSBmaW5pc2hlZCB3cml0aW5nIHZhbHVlXG4gICAgICAgICAgICAgICAgdHlwZW9mIHRoaXMuaW5wdXRUcmFuc2Zvcm1GbiAhPT0gJ2Z1bmN0aW9uJ1xuICAgICAgICAgICAgICAgICAgICA/ICh0aGlzLl9tYXNrU2VydmljZS53cml0aW5nVmFsdWUgPSBmYWxzZSlcbiAgICAgICAgICAgICAgICAgICAgOiAnJztcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuZm9ybUVsZW1lbnRQcm9wZXJ0eSA9IFsndmFsdWUnLCBpbnB1dFZhbHVlXTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHRoaXMuX2lucHV0VmFsdWUgPSBpbnB1dFZhbHVlO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgY29uc29sZS53YXJuKFxuICAgICAgICAgICAgICAgICdOZ3gtbWFzayB3cml0ZVZhbHVlIHdvcmsgd2l0aCBzdHJpbmcgfCBudW1iZXIsIHlvdXIgY3VycmVudCB2YWx1ZTonLFxuICAgICAgICAgICAgICAgIHR5cGVvZiBjb250cm9sVmFsdWVcbiAgICAgICAgICAgICk7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBwdWJsaWMgcmVnaXN0ZXJPbkNoYW5nZShmbjogdHlwZW9mIHRoaXMub25DaGFuZ2UpOiB2b2lkIHtcbiAgICAgICAgdGhpcy5fbWFza1NlcnZpY2Uub25DaGFuZ2UgPSB0aGlzLm9uQ2hhbmdlID0gZm47XG4gICAgfVxuXG4gICAgcHVibGljIHJlZ2lzdGVyT25Ub3VjaGVkKGZuOiB0eXBlb2YgdGhpcy5vblRvdWNoKTogdm9pZCB7XG4gICAgICAgIHRoaXMub25Ub3VjaCA9IGZuO1xuICAgIH1cblxuICAgIHByaXZhdGUgX2dldEFjdGl2ZUVsZW1lbnQoZG9jdW1lbnQ6IERvY3VtZW50T3JTaGFkb3dSb290ID0gdGhpcy5kb2N1bWVudCk6IEVsZW1lbnQgfCBudWxsIHtcbiAgICAgICAgY29uc3Qgc2hhZG93Um9vdEVsID0gZG9jdW1lbnQ/LmFjdGl2ZUVsZW1lbnQ/LnNoYWRvd1Jvb3Q7XG4gICAgICAgIGlmICghc2hhZG93Um9vdEVsPy5hY3RpdmVFbGVtZW50KSB7XG4gICAgICAgICAgICByZXR1cm4gZG9jdW1lbnQuYWN0aXZlRWxlbWVudDtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiB0aGlzLl9nZXRBY3RpdmVFbGVtZW50KHNoYWRvd1Jvb3RFbCk7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBwdWJsaWMgY2hlY2tTZWxlY3Rpb25PbkRlbGV0aW9uKGVsOiBIVE1MSW5wdXRFbGVtZW50KTogdm9pZCB7XG4gICAgICAgIGVsLnNlbGVjdGlvblN0YXJ0ID0gTWF0aC5taW4oXG4gICAgICAgICAgICBNYXRoLm1heCh0aGlzLnByZWZpeC5sZW5ndGgsIGVsLnNlbGVjdGlvblN0YXJ0IGFzIG51bWJlciksXG4gICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlLmxlbmd0aCAtIHRoaXMuc3VmZml4Lmxlbmd0aFxuICAgICAgICApO1xuICAgICAgICBlbC5zZWxlY3Rpb25FbmQgPSBNYXRoLm1pbihcbiAgICAgICAgICAgIE1hdGgubWF4KHRoaXMucHJlZml4Lmxlbmd0aCwgZWwuc2VsZWN0aW9uRW5kIGFzIG51bWJlciksXG4gICAgICAgICAgICB0aGlzLl9pbnB1dFZhbHVlLmxlbmd0aCAtIHRoaXMuc3VmZml4Lmxlbmd0aFxuICAgICAgICApO1xuICAgIH1cblxuICAgIC8qKiBJdCBkaXNhYmxlcyB0aGUgaW5wdXQgZWxlbWVudCAqL1xuICAgIHB1YmxpYyBzZXREaXNhYmxlZFN0YXRlKGlzRGlzYWJsZWQ6IGJvb2xlYW4pOiB2b2lkIHtcbiAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuZm9ybUVsZW1lbnRQcm9wZXJ0eSA9IFsnZGlzYWJsZWQnLCBpc0Rpc2FibGVkXTtcbiAgICB9XG5cbiAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgQHR5cGVzY3JpcHQtZXNsaW50L25vLWV4cGxpY2l0LWFueVxuICAgIHByaXZhdGUgX2FwcGx5TWFzaygpOiBhbnkge1xuICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiA9IHRoaXMuX21hc2tTZXJ2aWNlLl9yZXBlYXRQYXR0ZXJuU3ltYm9scyhcbiAgICAgICAgICAgIHRoaXMuX21hc2tWYWx1ZSB8fCAnJ1xuICAgICAgICApO1xuICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5mb3JtRWxlbWVudFByb3BlcnR5ID0gW1xuICAgICAgICAgICAgJ3ZhbHVlJyxcbiAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLmFwcGx5TWFzayh0aGlzLl9pbnB1dFZhbHVlLCB0aGlzLl9tYXNrU2VydmljZS5tYXNrRXhwcmVzc2lvbiksXG4gICAgICAgIF07XG4gICAgfVxuXG4gICAgcHJpdmF0ZSBfdmFsaWRhdGVUaW1lKHZhbHVlOiBzdHJpbmcpOiBWYWxpZGF0aW9uRXJyb3JzIHwgbnVsbCB7XG4gICAgICAgIGNvbnN0IHJvd01hc2tMZW46IG51bWJlciA9IHRoaXMuX21hc2tWYWx1ZVxuICAgICAgICAgICAgLnNwbGl0KE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORylcbiAgICAgICAgICAgIC5maWx0ZXIoKHM6IHN0cmluZykgPT4gcyAhPT0gJzonKS5sZW5ndGg7XG4gICAgICAgIGlmICghdmFsdWUpIHtcbiAgICAgICAgICAgIHJldHVybiBudWxsOyAvLyBEb24ndCB2YWxpZGF0ZSBlbXB0eSB2YWx1ZXMgdG8gYWxsb3cgZm9yIG9wdGlvbmFsIGZvcm0gY29udHJvbFxuICAgICAgICB9XG5cbiAgICAgICAgaWYgKFxuICAgICAgICAgICAgKCsodmFsdWVbdmFsdWUubGVuZ3RoIC0gMV0gPz8gLTEpID09PSAwICYmIHZhbHVlLmxlbmd0aCA8IHJvd01hc2tMZW4pIHx8XG4gICAgICAgICAgICB2YWx1ZS5sZW5ndGggPD0gcm93TWFza0xlbiAtIDJcbiAgICAgICAgKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5fY3JlYXRlVmFsaWRhdGlvbkVycm9yKHZhbHVlKTtcbiAgICAgICAgfVxuXG4gICAgICAgIHJldHVybiBudWxsO1xuICAgIH1cblxuICAgIHByaXZhdGUgX2dldEFjdHVhbElucHV0TGVuZ3RoKCkge1xuICAgICAgICByZXR1cm4gKFxuICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UuYWN0dWFsVmFsdWUubGVuZ3RoIHx8XG4gICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5hY3R1YWxWYWx1ZS5sZW5ndGggKyB0aGlzLl9tYXNrU2VydmljZS5wcmVmaXgubGVuZ3RoXG4gICAgICAgICk7XG4gICAgfVxuXG4gICAgcHJpdmF0ZSBfY3JlYXRlVmFsaWRhdGlvbkVycm9yKGFjdHVhbFZhbHVlOiBzdHJpbmcpOiBWYWxpZGF0aW9uRXJyb3JzIHtcbiAgICAgICAgcmV0dXJuIHtcbiAgICAgICAgICAgIG1hc2s6IHtcbiAgICAgICAgICAgICAgICByZXF1aXJlZE1hc2s6IHRoaXMuX21hc2tWYWx1ZSxcbiAgICAgICAgICAgICAgICBhY3R1YWxWYWx1ZSxcbiAgICAgICAgICAgIH0sXG4gICAgICAgIH07XG4gICAgfVxuXG4gICAgcHJpdmF0ZSBfc2V0TWFzaygpIHtcbiAgICAgICAgdGhpcy5fbWFza0V4cHJlc3Npb25BcnJheS5zb21lKChtYXNrKTogYm9vbGVhbiB8IHZvaWQgPT4ge1xuICAgICAgICAgICAgY29uc3Qgc3BlY2lhbENoYXJ0OiBib29sZWFuID0gbWFza1xuICAgICAgICAgICAgICAgIC5zcGxpdChNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkcpXG4gICAgICAgICAgICAgICAgLnNvbWUoKGNoYXIpID0+IHRoaXMuX21hc2tTZXJ2aWNlLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKGNoYXIpKTtcbiAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAoc3BlY2lhbENoYXJ0ICYmIHRoaXMuX2lucHV0VmFsdWUgJiYgIW1hc2suaW5jbHVkZXMoTWFza0V4cHJlc3Npb24uTEVUVEVSX1MpKSB8fFxuICAgICAgICAgICAgICAgIG1hc2suaW5jbHVkZXMoTWFza0V4cHJlc3Npb24uQ1VSTFlfQlJBQ0tFVFNfTEVGVClcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIGNvbnN0IHRlc3QgPVxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrU2VydmljZS5yZW1vdmVNYXNrKHRoaXMuX2lucHV0VmFsdWUpPy5sZW5ndGggPD1cbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UucmVtb3ZlTWFzayhtYXNrKT8ubGVuZ3RoO1xuICAgICAgICAgICAgICAgIGlmICh0ZXN0KSB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLm1hc2tFeHByZXNzaW9uID1cbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX21hc2tTZXJ2aWNlLm1hc2tFeHByZXNzaW9uID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXNrLmluY2x1ZGVzKE1hc2tFeHByZXNzaW9uLkNVUkxZX0JSQUNLRVRTX0xFRlQpXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID8gdGhpcy5fbWFza1NlcnZpY2UuX3JlcGVhdFBhdHRlcm5TeW1ib2xzKG1hc2spXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogbWFzaztcbiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRlc3Q7XG4gICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgY29uc3QgZXhwcmVzc2lvbiA9XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrRXhwcmVzc2lvbkFycmF5W3RoaXMuX21hc2tFeHByZXNzaW9uQXJyYXkubGVuZ3RoIC0gMV0gPz9cbiAgICAgICAgICAgICAgICAgICAgICAgIE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORztcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1ZhbHVlID1cbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMubWFza0V4cHJlc3Npb24gPVxuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fbWFza1NlcnZpY2UubWFza0V4cHJlc3Npb24gPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4cHJlc3Npb24uaW5jbHVkZXMoTWFza0V4cHJlc3Npb24uQ1VSTFlfQlJBQ0tFVFNfTEVGVClcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPyB0aGlzLl9tYXNrU2VydmljZS5fcmVwZWF0UGF0dGVyblN5bWJvbHMoZXhwcmVzc2lvbilcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBleHByZXNzaW9uO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgY29uc3QgY2hlY2s6IGJvb2xlYW4gPSB0aGlzLl9tYXNrU2VydmljZVxuICAgICAgICAgICAgICAgICAgICAucmVtb3ZlTWFzayh0aGlzLl9pbnB1dFZhbHVlKVxuICAgICAgICAgICAgICAgICAgICA/LnNwbGl0KE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORylcbiAgICAgICAgICAgICAgICAgICAgLmV2ZXJ5KChjaGFyYWN0ZXIsIGluZGV4KSA9PiB7XG4gICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBpbmRleE1hc2sgPSBtYXNrLmNoYXJBdChpbmRleCk7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdGhpcy5fbWFza1NlcnZpY2UuX2NoZWNrU3ltYm9sTWFzayhjaGFyYWN0ZXIsIGluZGV4TWFzayk7XG4gICAgICAgICAgICAgICAgICAgIH0pO1xuICAgICAgICAgICAgICAgIGlmIChjaGVjaykge1xuICAgICAgICAgICAgICAgICAgICB0aGlzLl9tYXNrVmFsdWUgPSB0aGlzLm1hc2tFeHByZXNzaW9uID0gdGhpcy5fbWFza1NlcnZpY2UubWFza0V4cHJlc3Npb24gPSBtYXNrO1xuICAgICAgICAgICAgICAgICAgICByZXR1cm4gY2hlY2s7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9KTtcbiAgICB9XG59XG4iXX0=