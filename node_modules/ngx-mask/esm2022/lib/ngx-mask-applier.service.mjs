import { inject, Injectable } from '@angular/core';
import { NGX_MASK_CONFIG } from './ngx-mask.config';
import * as i0 from "@angular/core";
export class NgxMaskApplierService {
    constructor() {
        this._config = inject(NGX_MASK_CONFIG);
        this.dropSpecialCharacters = this._config.dropSpecialCharacters;
        this.hiddenInput = this._config.hiddenInput;
        this.clearIfNotMatch = this._config.clearIfNotMatch;
        this.specialCharacters = this._config.specialCharacters;
        this.patterns = this._config.patterns;
        this.prefix = this._config.prefix;
        this.suffix = this._config.suffix;
        this.thousandSeparator = this._config.thousandSeparator;
        this.decimalMarker = this._config.decimalMarker;
        this.showMaskTyped = this._config.showMaskTyped;
        this.placeHolderCharacter = this._config.placeHolderCharacter;
        this.validation = this._config.validation;
        this.separatorLimit = this._config.separatorLimit;
        this.allowNegativeNumbers = this._config.allowNegativeNumbers;
        this.leadZeroDateTime = this._config.leadZeroDateTime;
        this.leadZero = this._config.leadZero;
        this.apm = this._config.apm;
        this.inputTransformFn = this._config.inputTransformFn;
        this.outputTransformFn = this._config.outputTransformFn;
        this.keepCharacterPositions = this._config.keepCharacterPositions;
        this._shift = new Set();
        this.plusOnePosition = false;
        this.maskExpression = '';
        this.actualValue = '';
        this.showKeepCharacterExp = '';
        this.shownMaskExpression = '';
        this.deletedSpecialCharacter = false;
        this._formatWithSeparators = (str, thousandSeparatorChar, decimalChars, precision) => {
            let x = [];
            let decimalChar = '';
            if (Array.isArray(decimalChars)) {
                const regExp = new RegExp(decimalChars.map((v) => ('[\\^$.|?*+()'.indexOf(v) >= 0 ? `\\${v}` : v)).join('|'));
                x = str.split(regExp);
                decimalChar = str.match(regExp)?.[0] ?? "" /* MaskExpression.EMPTY_STRING */;
            }
            else {
                x = str.split(decimalChars);
                decimalChar = decimalChars;
            }
            const decimals = x.length > 1 ? `${decimalChar}${x[1]}` : "" /* MaskExpression.EMPTY_STRING */;
            let res = x[0] ?? "" /* MaskExpression.EMPTY_STRING */;
            const separatorLimit = this.separatorLimit.replace(/\s/g, "" /* MaskExpression.EMPTY_STRING */);
            if (separatorLimit && +separatorLimit) {
                if (res[0] === "-" /* MaskExpression.MINUS */) {
                    res = `-${res.slice(1, res.length).slice(0, separatorLimit.length)}`;
                }
                else {
                    res = res.slice(0, separatorLimit.length);
                }
            }
            const rgx = /(\d+)(\d{3})/;
            while (thousandSeparatorChar && rgx.test(res)) {
                res = res.replace(rgx, '$1' + thousandSeparatorChar + '$2');
            }
            if (precision === undefined) {
                return res + decimals;
            }
            else if (precision === 0) {
                return res;
            }
            return res + decimals.substring(0, precision + 1);
        };
        this.percentage = (str) => {
            const sanitizedStr = str.replace(',', '.');
            const value = Number(sanitizedStr);
            return !isNaN(value) && value >= 0 && value <= 100;
        };
        this.getPrecision = (maskExpression) => {
            const x = maskExpression.split("." /* MaskExpression.DOT */);
            if (x.length > 1) {
                return Number(x[x.length - 1]);
            }
            return Infinity;
        };
        this.checkAndRemoveSuffix = (inputValue) => {
            for (let i = this.suffix?.length - 1; i >= 0; i--) {
                const substr = this.suffix.substring(i, this.suffix?.length);
                if (inputValue.includes(substr) &&
                    i !== this.suffix?.length - 1 &&
                    (i - 1 < 0 ||
                        !inputValue.includes(this.suffix.substring(i - 1, this.suffix?.length)))) {
                    return inputValue.replace(substr, "" /* MaskExpression.EMPTY_STRING */);
                }
            }
            return inputValue;
        };
        this.checkInputPrecision = (inputValue, precision, decimalMarker) => {
            if (precision < Infinity) {
                // TODO need think about decimalMarker
                if (Array.isArray(decimalMarker)) {
                    const marker = decimalMarker.find((dm) => dm !== this.thousandSeparator);
                    // eslint-disable-next-line no-param-reassign
                    decimalMarker = marker ? marker : decimalMarker[0];
                }
                const precisionRegEx = new RegExp(this._charToRegExpExpression(decimalMarker) + `\\d{${precision}}.*$`);
                const precisionMatch = inputValue.match(precisionRegEx);
                const precisionMatchLength = (precisionMatch && precisionMatch[0]?.length) ?? 0;
                if (precisionMatchLength - 1 > precision) {
                    const diff = precisionMatchLength - 1 - precision;
                    // eslint-disable-next-line no-param-reassign
                    inputValue = inputValue.substring(0, inputValue.length - diff);
                }
                if (precision === 0 &&
                    this._compareOrIncludes(inputValue[inputValue.length - 1], decimalMarker, this.thousandSeparator)) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue = inputValue.substring(0, inputValue.length - 1);
                }
            }
            return inputValue;
        };
    }
    applyMaskWithPattern(inputValue, maskAndPattern) {
        const [mask, customPattern] = maskAndPattern;
        this.customPattern = customPattern;
        return this.applyMask(inputValue, mask);
    }
    applyMask(inputValue, maskExpression, position = 0, justPasted = false, backspaced = false, 
    // eslint-disable-next-line @typescript-eslint/no-empty-function, @typescript-eslint/no-explicit-any
    cb = () => { }) {
        if (!maskExpression || typeof inputValue !== 'string') {
            return "" /* MaskExpression.EMPTY_STRING */;
        }
        let cursor = 0;
        let result = '';
        let multi = false;
        let backspaceShift = false;
        let shift = 1;
        let stepBack = false;
        if (inputValue.slice(0, this.prefix.length) === this.prefix) {
            // eslint-disable-next-line no-param-reassign
            inputValue = inputValue.slice(this.prefix.length, inputValue.length);
        }
        if (!!this.suffix && inputValue?.length > 0) {
            // eslint-disable-next-line no-param-reassign
            inputValue = this.checkAndRemoveSuffix(inputValue);
        }
        if (inputValue === '(' && this.prefix) {
            // eslint-disable-next-line no-param-reassign
            inputValue = '';
        }
        const inputArray = inputValue.toString().split("" /* MaskExpression.EMPTY_STRING */);
        if (this.allowNegativeNumbers &&
            inputValue.slice(cursor, cursor + 1) === "-" /* MaskExpression.MINUS */) {
            // eslint-disable-next-line no-param-reassign
            result += inputValue.slice(cursor, cursor + 1);
        }
        if (maskExpression === "IP" /* MaskExpression.IP */) {
            const valuesIP = inputValue.split("." /* MaskExpression.DOT */);
            this.ipError = this._validIP(valuesIP);
            // eslint-disable-next-line no-param-reassign
            maskExpression = '099.099.099.099';
        }
        const arr = [];
        for (let i = 0; i < inputValue.length; i++) {
            if (inputValue[i]?.match('\\d')) {
                arr.push(inputValue[i] ?? "" /* MaskExpression.EMPTY_STRING */);
            }
        }
        if (maskExpression === "CPF_CNPJ" /* MaskExpression.CPF_CNPJ */) {
            this.cpfCnpjError = arr.length !== 11 && arr.length !== 14;
            if (arr.length > 11) {
                // eslint-disable-next-line no-param-reassign
                maskExpression = '00.000.000/0000-00';
            }
            else {
                // eslint-disable-next-line no-param-reassign
                maskExpression = '000.000.000-00';
            }
        }
        if (maskExpression.startsWith("percent" /* MaskExpression.PERCENT */)) {
            if (inputValue.match('[a-z]|[A-Z]') ||
                // eslint-disable-next-line no-useless-escape
                (inputValue.match(/[-!$%^&*()_+|~=`{}\[\]:";'<>?,\/.]/) && !backspaced)) {
                // eslint-disable-next-line no-param-reassign
                inputValue = this._stripToDecimal(inputValue);
                const precision = this.getPrecision(maskExpression);
                // eslint-disable-next-line no-param-reassign
                inputValue = this.checkInputPrecision(inputValue, precision, this.decimalMarker);
            }
            const decimalMarker = typeof this.decimalMarker === 'string' ? this.decimalMarker : "." /* MaskExpression.DOT */;
            if (inputValue.indexOf(decimalMarker) > 0 &&
                !this.percentage(inputValue.substring(0, inputValue.indexOf(decimalMarker)))) {
                let base = inputValue.substring(0, inputValue.indexOf(decimalMarker) - 1);
                if (this.allowNegativeNumbers &&
                    inputValue.slice(cursor, cursor + 1) === "-" /* MaskExpression.MINUS */ &&
                    !backspaced) {
                    base = inputValue.substring(0, inputValue.indexOf(decimalMarker));
                }
                // eslint-disable-next-line no-param-reassign
                inputValue = `${base}${inputValue.substring(inputValue.indexOf(decimalMarker), inputValue.length)}`;
            }
            let value = '';
            this.allowNegativeNumbers &&
                inputValue.slice(cursor, cursor + 1) === "-" /* MaskExpression.MINUS */
                ? (value = inputValue.slice(cursor + 1, cursor + inputValue.length))
                : (value = inputValue);
            if (this.percentage(value)) {
                result = this._splitPercentZero(inputValue);
            }
            else {
                result = this._splitPercentZero(inputValue.substring(0, inputValue.length - 1));
            }
        }
        else if (maskExpression.startsWith("separator" /* MaskExpression.SEPARATOR */)) {
            if (inputValue.match('[wа-яА-Я]') ||
                inputValue.match('[ЁёА-я]') ||
                inputValue.match('[a-z]|[A-Z]') ||
                inputValue.match(/[-@#!$%\\^&*()_£¬'+|~=`{}\]:";<>.?/]/) ||
                inputValue.match('[^A-Za-z0-9,]')) {
                // eslint-disable-next-line no-param-reassign
                inputValue = this._stripToDecimal(inputValue);
            }
            const precision = this.getPrecision(maskExpression);
            const decimalMarker = Array.isArray(this.decimalMarker)
                ? "." /* MaskExpression.DOT */
                : this.decimalMarker;
            if (precision === 0) {
                // eslint-disable-next-line no-param-reassign
                inputValue = this.allowNegativeNumbers
                    ? inputValue.length > 2 &&
                        inputValue[0] === "-" /* MaskExpression.MINUS */ &&
                        inputValue[1] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                        inputValue[2] !== this.thousandSeparator &&
                        inputValue[2] !== "," /* MaskExpression.COMMA */ &&
                        inputValue[2] !== "." /* MaskExpression.DOT */
                        ? '-' + inputValue.slice(2, inputValue.length)
                        : inputValue[0] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                            inputValue.length > 1 &&
                            inputValue[1] !== this.thousandSeparator &&
                            inputValue[1] !== "," /* MaskExpression.COMMA */ &&
                            inputValue[1] !== "." /* MaskExpression.DOT */
                            ? inputValue.slice(1, inputValue.length)
                            : inputValue
                    : inputValue.length > 1 &&
                        inputValue[0] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                        inputValue[1] !== this.thousandSeparator &&
                        inputValue[1] !== "," /* MaskExpression.COMMA */ &&
                        inputValue[1] !== "." /* MaskExpression.DOT */
                        ? inputValue.slice(1, inputValue.length)
                        : inputValue;
            }
            else {
                // eslint-disable-next-line no-param-reassign
                if (inputValue[0] === decimalMarker && inputValue.length > 1) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue =
                        "0" /* MaskExpression.NUMBER_ZERO */ + inputValue.slice(0, inputValue.length + 1);
                    this.plusOnePosition = true;
                }
                if (inputValue[0] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                    inputValue[1] !== decimalMarker &&
                    inputValue[1] !== this.thousandSeparator) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue =
                        inputValue.length > 1
                            ? inputValue.slice(0, 1) +
                                decimalMarker +
                                inputValue.slice(1, inputValue.length + 1)
                            : inputValue;
                    this.plusOnePosition = true;
                }
                if (this.allowNegativeNumbers &&
                    inputValue[0] === "-" /* MaskExpression.MINUS */ &&
                    (inputValue[1] === decimalMarker ||
                        inputValue[1] === "0" /* MaskExpression.NUMBER_ZERO */)) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue =
                        inputValue[1] === decimalMarker && inputValue.length > 2
                            ? inputValue.slice(0, 1) +
                                "0" /* MaskExpression.NUMBER_ZERO */ +
                                inputValue.slice(1, inputValue.length)
                            : inputValue[1] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                                inputValue.length > 2 &&
                                inputValue[2] !== decimalMarker
                                ? inputValue.slice(0, 2) +
                                    decimalMarker +
                                    inputValue.slice(2, inputValue.length)
                                : inputValue;
                    this.plusOnePosition = true;
                }
            }
            if (backspaced) {
                if (inputValue[0] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                    inputValue[1] === this.decimalMarker &&
                    (inputValue[position] === "0" /* MaskExpression.NUMBER_ZERO */ ||
                        inputValue[position] === this.decimalMarker)) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue = inputValue.slice(2, inputValue.length);
                }
                if (inputValue[0] === "-" /* MaskExpression.MINUS */ &&
                    inputValue[1] === "0" /* MaskExpression.NUMBER_ZERO */ &&
                    inputValue[2] === this.decimalMarker &&
                    (inputValue[position] === "0" /* MaskExpression.NUMBER_ZERO */ ||
                        inputValue[position] === this.decimalMarker)) {
                    // eslint-disable-next-line no-param-reassign
                    inputValue = "-" /* MaskExpression.MINUS */ + inputValue.slice(3, inputValue.length);
                }
                // eslint-disable-next-line no-param-reassign
                inputValue = this._compareOrIncludes(inputValue[inputValue.length - 1], this.decimalMarker, this.thousandSeparator)
                    ? inputValue.slice(0, inputValue.length - 1)
                    : inputValue;
            }
            // TODO: we had different rexexps here for the different cases... but tests dont seam to bother - check this
            //  separator: no COMMA, dot-sep: no SPACE, COMMA OK, comma-sep: no SPACE, COMMA OK
            const thousandSeparatorCharEscaped = this._charToRegExpExpression(this.thousandSeparator);
            let invalidChars = '@#!$%^&*()_+|~=`{}\\[\\]:\\s,\\.";<>?\\/'.replace(thousandSeparatorCharEscaped, '');
            //.replace(decimalMarkerEscaped, '');
            if (Array.isArray(this.decimalMarker)) {
                for (const marker of this.decimalMarker) {
                    invalidChars = invalidChars.replace(this._charToRegExpExpression(marker), "" /* MaskExpression.EMPTY_STRING */);
                }
            }
            else {
                invalidChars = invalidChars.replace(this._charToRegExpExpression(this.decimalMarker), '');
            }
            const invalidCharRegexp = new RegExp('[' + invalidChars + ']');
            if (inputValue.match(invalidCharRegexp)) {
                // eslint-disable-next-line no-param-reassign
                inputValue = inputValue.substring(0, inputValue.length - 1);
            }
            // eslint-disable-next-line no-param-reassign
            inputValue = this.checkInputPrecision(inputValue, precision, this.decimalMarker);
            const strForSep = inputValue.replace(new RegExp(thousandSeparatorCharEscaped, 'g'), '');
            result = this._formatWithSeparators(strForSep, this.thousandSeparator, this.decimalMarker, precision);
            const commaShift = result.indexOf("," /* MaskExpression.COMMA */) - inputValue.indexOf("," /* MaskExpression.COMMA */);
            const shiftStep = result.length - inputValue.length;
            if (shiftStep > 0 && result[position] !== this.thousandSeparator) {
                backspaceShift = true;
                let _shift = 0;
                do {
                    this._shift.add(position + _shift);
                    _shift++;
                } while (_shift < shiftStep);
            }
            else if (result[position - 1] === this.decimalMarker ||
                shiftStep === -4 ||
                shiftStep === -3 ||
                result[position] === "," /* MaskExpression.COMMA */) {
                this._shift.clear();
                this._shift.add(position - 1);
            }
            else if ((commaShift !== 0 &&
                position > 0 &&
                !(result.indexOf("," /* MaskExpression.COMMA */) >= position && position > 3)) ||
                (!(result.indexOf("." /* MaskExpression.DOT */) >= position && position > 3) &&
                    shiftStep <= 0)) {
                this._shift.clear();
                backspaceShift = true;
                shift = shiftStep;
                // eslint-disable-next-line no-param-reassign
                position += shiftStep;
                this._shift.add(position);
            }
            else {
                this._shift.clear();
            }
        }
        else {
            for (
            // eslint-disable-next-line
            let i = 0, inputSymbol = inputArray[0]; i < inputArray.length; i++, inputSymbol = inputArray[i] ?? "" /* MaskExpression.EMPTY_STRING */) {
                if (cursor === maskExpression.length) {
                    break;
                }
                const symbolStarInPattern = "*" /* MaskExpression.SYMBOL_STAR */ in this.patterns;
                if (this._checkSymbolMask(inputSymbol, maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */) &&
                    maskExpression[cursor + 1] === "?" /* MaskExpression.SYMBOL_QUESTION */) {
                    result += inputSymbol;
                    cursor += 2;
                }
                else if (maskExpression[cursor + 1] === "*" /* MaskExpression.SYMBOL_STAR */ &&
                    multi &&
                    this._checkSymbolMask(inputSymbol, maskExpression[cursor + 2] ?? "" /* MaskExpression.EMPTY_STRING */)) {
                    result += inputSymbol;
                    cursor += 3;
                    multi = false;
                }
                else if (this._checkSymbolMask(inputSymbol, maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */) &&
                    maskExpression[cursor + 1] === "*" /* MaskExpression.SYMBOL_STAR */ &&
                    !symbolStarInPattern) {
                    result += inputSymbol;
                    multi = true;
                }
                else if (maskExpression[cursor + 1] === "?" /* MaskExpression.SYMBOL_QUESTION */ &&
                    this._checkSymbolMask(inputSymbol, maskExpression[cursor + 2] ?? "" /* MaskExpression.EMPTY_STRING */)) {
                    result += inputSymbol;
                    cursor += 3;
                }
                else if (this._checkSymbolMask(inputSymbol, maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */)) {
                    if (maskExpression[cursor] === "H" /* MaskExpression.HOURS */) {
                        if (this.apm ? Number(inputSymbol) > 9 : Number(inputSymbol) > 2) {
                            // eslint-disable-next-line no-param-reassign
                            position = !this.leadZeroDateTime ? position + 1 : position;
                            cursor += 1;
                            this._shiftStep(maskExpression, cursor, inputArray.length);
                            i--;
                            if (this.leadZeroDateTime) {
                                result += '0';
                            }
                            continue;
                        }
                    }
                    if (maskExpression[cursor] === "h" /* MaskExpression.HOUR */) {
                        if (this.apm
                            ? (result.length === 1 && Number(result) > 1) ||
                                (result === '1' && Number(inputSymbol) > 2) ||
                                (inputValue.slice(cursor - 1, cursor).length === 1 &&
                                    Number(inputValue.slice(cursor - 1, cursor)) > 2) ||
                                (inputValue.slice(cursor - 1, cursor) === '1' &&
                                    Number(inputSymbol) > 2)
                            : (result === '2' && Number(inputSymbol) > 3) ||
                                ((result.slice(cursor - 2, cursor) === '2' ||
                                    result.slice(cursor - 3, cursor) === '2' ||
                                    result.slice(cursor - 4, cursor) === '2' ||
                                    result.slice(cursor - 1, cursor) === '2') &&
                                    Number(inputSymbol) > 3 &&
                                    cursor > 10)) {
                            // eslint-disable-next-line no-param-reassign
                            position = position + 1;
                            cursor += 1;
                            i--;
                            continue;
                        }
                    }
                    if (maskExpression[cursor] === "m" /* MaskExpression.MINUTE */ ||
                        maskExpression[cursor] === "s" /* MaskExpression.SECOND */) {
                        if (Number(inputSymbol) > 5) {
                            // eslint-disable-next-line no-param-reassign
                            position = !this.leadZeroDateTime ? position + 1 : position;
                            cursor += 1;
                            this._shiftStep(maskExpression, cursor, inputArray.length);
                            i--;
                            if (this.leadZeroDateTime) {
                                result += '0';
                            }
                            continue;
                        }
                    }
                    const daysCount = 31;
                    const inputValueCursor = inputValue[cursor];
                    const inputValueCursorPlusOne = inputValue[cursor + 1];
                    const inputValueCursorPlusTwo = inputValue[cursor + 2];
                    const inputValueCursorMinusOne = inputValue[cursor - 1];
                    const inputValueCursorMinusTwo = inputValue[cursor - 2];
                    const inputValueCursorMinusThree = inputValue[cursor - 3];
                    const inputValueSliceMinusThreeMinusOne = inputValue.slice(cursor - 3, cursor - 1);
                    const inputValueSliceMinusOnePlusOne = inputValue.slice(cursor - 1, cursor + 1);
                    const inputValueSliceCursorPlusTwo = inputValue.slice(cursor, cursor + 2);
                    const inputValueSliceMinusTwoCursor = inputValue.slice(cursor - 2, cursor);
                    if (maskExpression[cursor] === "d" /* MaskExpression.DAY */) {
                        const maskStartWithMonth = maskExpression.slice(0, 2) === "M0" /* MaskExpression.MONTHS */;
                        const startWithMonthInput = maskExpression.slice(0, 2) === "M0" /* MaskExpression.MONTHS */ &&
                            this.specialCharacters.includes(inputValueCursorMinusTwo);
                        if ((Number(inputSymbol) > 3 && this.leadZeroDateTime) ||
                            (!maskStartWithMonth &&
                                (Number(inputValueSliceCursorPlusTwo) > daysCount ||
                                    Number(inputValueSliceMinusOnePlusOne) > daysCount ||
                                    this.specialCharacters.includes(inputValueCursorPlusOne))) ||
                            (startWithMonthInput
                                ? Number(inputValueSliceMinusOnePlusOne) > daysCount ||
                                    (!this.specialCharacters.includes(inputValueCursor) &&
                                        this.specialCharacters.includes(inputValueCursorPlusTwo)) ||
                                    this.specialCharacters.includes(inputValueCursor)
                                : Number(inputValueSliceCursorPlusTwo) > daysCount ||
                                    this.specialCharacters.includes(inputValueCursorPlusOne))) {
                            // eslint-disable-next-line no-param-reassign
                            position = !this.leadZeroDateTime ? position + 1 : position;
                            cursor += 1;
                            this._shiftStep(maskExpression, cursor, inputArray.length);
                            i--;
                            if (this.leadZeroDateTime) {
                                result += '0';
                            }
                            continue;
                        }
                    }
                    if (maskExpression[cursor] === "M" /* MaskExpression.MONTH */) {
                        const monthsCount = 12;
                        // mask without day
                        const withoutDays = cursor === 0 &&
                            (Number(inputSymbol) > 2 ||
                                Number(inputValueSliceCursorPlusTwo) > monthsCount ||
                                this.specialCharacters.includes(inputValueCursorPlusOne));
                        // day<10 && month<12 for input
                        const specialChart = maskExpression.slice(cursor + 2, cursor + 3);
                        const day1monthInput = inputValueSliceMinusThreeMinusOne.includes(specialChart) &&
                            ((this.specialCharacters.includes(inputValueCursorMinusTwo) &&
                                Number(inputValueSliceMinusOnePlusOne) > monthsCount &&
                                !this.specialCharacters.includes(inputValueCursor)) ||
                                this.specialCharacters.includes(inputValueCursor) ||
                                (this.specialCharacters.includes(inputValueCursorMinusThree) &&
                                    Number(inputValueSliceMinusTwoCursor) > monthsCount &&
                                    !this.specialCharacters.includes(inputValueCursorMinusOne)) ||
                                this.specialCharacters.includes(inputValueCursorMinusOne));
                        //  month<12 && day<10 for input
                        const day2monthInput = Number(inputValueSliceMinusThreeMinusOne) <= daysCount &&
                            !this.specialCharacters.includes(inputValueSliceMinusThreeMinusOne) &&
                            this.specialCharacters.includes(inputValueCursorMinusOne) &&
                            (Number(inputValueSliceCursorPlusTwo) > monthsCount ||
                                this.specialCharacters.includes(inputValueCursorPlusOne));
                        // cursor === 5 && without days
                        const day2monthInputDot = (Number(inputValueSliceCursorPlusTwo) > monthsCount && cursor === 5) ||
                            (this.specialCharacters.includes(inputValueCursorPlusOne) &&
                                cursor === 5);
                        // // day<10 && month<12 for paste whole data
                        const day1monthPaste = Number(inputValueSliceMinusThreeMinusOne) > daysCount &&
                            !this.specialCharacters.includes(inputValueSliceMinusThreeMinusOne) &&
                            !this.specialCharacters.includes(inputValueSliceMinusTwoCursor) &&
                            Number(inputValueSliceMinusTwoCursor) > monthsCount;
                        // 10<day<31 && month<12 for paste whole data
                        const day2monthPaste = Number(inputValueSliceMinusThreeMinusOne) <= daysCount &&
                            !this.specialCharacters.includes(inputValueSliceMinusThreeMinusOne) &&
                            !this.specialCharacters.includes(inputValueCursorMinusOne) &&
                            Number(inputValueSliceMinusOnePlusOne) > monthsCount;
                        if ((Number(inputSymbol) > 1 && this.leadZeroDateTime) ||
                            withoutDays ||
                            day1monthInput ||
                            day2monthPaste ||
                            day1monthPaste ||
                            day2monthInput ||
                            (day2monthInputDot && !this.leadZeroDateTime)) {
                            // eslint-disable-next-line no-param-reassign
                            position = !this.leadZeroDateTime ? position + 1 : position;
                            cursor += 1;
                            this._shiftStep(maskExpression, cursor, inputArray.length);
                            i--;
                            if (this.leadZeroDateTime) {
                                result += '0';
                            }
                            continue;
                        }
                    }
                    result += inputSymbol;
                    cursor++;
                }
                else if ((inputSymbol === " " /* MaskExpression.WHITE_SPACE */ &&
                    maskExpression[cursor] === " " /* MaskExpression.WHITE_SPACE */) ||
                    (inputSymbol === "/" /* MaskExpression.SLASH */ &&
                        maskExpression[cursor] === "/" /* MaskExpression.SLASH */)) {
                    result += inputSymbol;
                    cursor++;
                }
                else if (this.specialCharacters.indexOf(maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */) !== -1) {
                    result += maskExpression[cursor];
                    cursor++;
                    this._shiftStep(maskExpression, cursor, inputArray.length);
                    i--;
                }
                else if (maskExpression[cursor] === "9" /* MaskExpression.NUMBER_NINE */ &&
                    this.showMaskTyped) {
                    this._shiftStep(maskExpression, cursor, inputArray.length);
                }
                else if (this.patterns[maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */] &&
                    this.patterns[maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */]?.optional) {
                    if (!!inputArray[cursor] &&
                        maskExpression !== '099.099.099.099' &&
                        maskExpression !== '000.000.000-00' &&
                        maskExpression !== '00.000.000/0000-00' &&
                        !maskExpression.match(/^9+\.0+$/) &&
                        !this.patterns[maskExpression[cursor] ?? "" /* MaskExpression.EMPTY_STRING */]
                            ?.optional) {
                        result += inputArray[cursor];
                    }
                    if (maskExpression.includes("9" /* MaskExpression.NUMBER_NINE */ + "*" /* MaskExpression.SYMBOL_STAR */) &&
                        maskExpression.includes("0" /* MaskExpression.NUMBER_ZERO */ + "*" /* MaskExpression.SYMBOL_STAR */)) {
                        cursor++;
                    }
                    cursor++;
                    i--;
                }
                else if (this.maskExpression[cursor + 1] === "*" /* MaskExpression.SYMBOL_STAR */ &&
                    this._findSpecialChar(this.maskExpression[cursor + 2] ?? "" /* MaskExpression.EMPTY_STRING */) &&
                    this._findSpecialChar(inputSymbol) === this.maskExpression[cursor + 2] &&
                    multi) {
                    cursor += 3;
                    result += inputSymbol;
                }
                else if (this.maskExpression[cursor + 1] === "?" /* MaskExpression.SYMBOL_QUESTION */ &&
                    this._findSpecialChar(this.maskExpression[cursor + 2] ?? "" /* MaskExpression.EMPTY_STRING */) &&
                    this._findSpecialChar(inputSymbol) === this.maskExpression[cursor + 2] &&
                    multi) {
                    cursor += 3;
                    result += inputSymbol;
                }
                else if (this.showMaskTyped &&
                    this.specialCharacters.indexOf(inputSymbol) < 0 &&
                    inputSymbol !== this.placeHolderCharacter &&
                    this.placeHolderCharacter.length === 1) {
                    stepBack = true;
                }
            }
        }
        if (result.length + 1 === maskExpression.length &&
            this.specialCharacters.indexOf(maskExpression[maskExpression.length - 1] ?? "" /* MaskExpression.EMPTY_STRING */) !== -1) {
            result += maskExpression[maskExpression.length - 1];
        }
        let newPosition = position + 1;
        while (this._shift.has(newPosition)) {
            shift++;
            newPosition++;
        }
        let actualShift = justPasted && !maskExpression.startsWith("separator" /* MaskExpression.SEPARATOR */)
            ? cursor
            : this._shift.has(position)
                ? shift
                : 0;
        if (stepBack) {
            actualShift--;
        }
        cb(actualShift, backspaceShift);
        if (shift < 0) {
            this._shift.clear();
        }
        let onlySpecial = false;
        if (backspaced) {
            onlySpecial = inputArray.every((char) => this.specialCharacters.includes(char));
        }
        let res = `${this.prefix}${onlySpecial ? "" /* MaskExpression.EMPTY_STRING */ : result}${this.showMaskTyped ? '' : this.suffix}`;
        if (result.length === 0) {
            res = !this.dropSpecialCharacters ? `${this.prefix}${result}` : `${result}`;
        }
        if (result.includes("-" /* MaskExpression.MINUS */) && this.prefix && this.allowNegativeNumbers) {
            if (backspaced && result === "-" /* MaskExpression.MINUS */) {
                return '';
            }
            res = `${"-" /* MaskExpression.MINUS */}${this.prefix}${result
                .split("-" /* MaskExpression.MINUS */)
                .join("" /* MaskExpression.EMPTY_STRING */)}${this.suffix}`;
        }
        return res;
    }
    _findDropSpecialChar(inputSymbol) {
        if (Array.isArray(this.dropSpecialCharacters)) {
            return this.dropSpecialCharacters.find((val) => val === inputSymbol);
        }
        return this._findSpecialChar(inputSymbol);
    }
    _findSpecialChar(inputSymbol) {
        return this.specialCharacters.find((val) => val === inputSymbol);
    }
    _checkSymbolMask(inputSymbol, maskSymbol) {
        this.patterns = this.customPattern ? this.customPattern : this.patterns;
        return ((this.patterns[maskSymbol]?.pattern &&
            this.patterns[maskSymbol]?.pattern.test(inputSymbol)) ??
            false);
    }
    _stripToDecimal(str) {
        return str
            .split("" /* MaskExpression.EMPTY_STRING */)
            .filter((i, idx) => {
            const isDecimalMarker = typeof this.decimalMarker === 'string'
                ? i === this.decimalMarker
                : // TODO (inepipenko) use utility type
                    this.decimalMarker.includes(i);
            return (i.match('^-?\\d') ||
                i === this.thousandSeparator ||
                isDecimalMarker ||
                (i === "-" /* MaskExpression.MINUS */ && idx === 0 && this.allowNegativeNumbers));
        })
            .join("" /* MaskExpression.EMPTY_STRING */);
    }
    _charToRegExpExpression(char) {
        // if (Array.isArray(char)) {
        // 	return char.map((v) => ('[\\^$.|?*+()'.indexOf(v) >= 0 ? `\\${v}` : v)).join('|');
        // }
        if (char) {
            const charsToEscape = '[\\^$.|?*+()';
            return char === ' ' ? '\\s' : charsToEscape.indexOf(char) >= 0 ? `\\${char}` : char;
        }
        return char;
    }
    _shiftStep(maskExpression, cursor, inputLength) {
        const shiftStep = /[*?]/g.test(maskExpression.slice(0, cursor))
            ? inputLength
            : cursor;
        this._shift.add(shiftStep + this.prefix.length || 0);
    }
    _compareOrIncludes(value, comparedValue, excludedValue) {
        return Array.isArray(comparedValue)
            ? comparedValue.filter((v) => v !== excludedValue).includes(value)
            : value === comparedValue;
    }
    _validIP(valuesIP) {
        return !(valuesIP.length === 4 &&
            !valuesIP.some((value, index) => {
                if (valuesIP.length !== index + 1) {
                    return value === "" /* MaskExpression.EMPTY_STRING */ || Number(value) > 255;
                }
                return value === "" /* MaskExpression.EMPTY_STRING */ || Number(value.substring(0, 3)) > 255;
            }));
    }
    _splitPercentZero(value) {
        const decimalIndex = typeof this.decimalMarker === 'string'
            ? value.indexOf(this.decimalMarker)
            : value.indexOf("." /* MaskExpression.DOT */);
        if (decimalIndex === -1) {
            const parsedValue = parseInt(value, 10);
            return isNaN(parsedValue) ? "" /* MaskExpression.EMPTY_STRING */ : parsedValue.toString();
        }
        else {
            const integerPart = parseInt(value.substring(0, decimalIndex), 10);
            const decimalPart = value.substring(decimalIndex + 1);
            const integerString = isNaN(integerPart) ? '' : integerPart.toString();
            const decimal = typeof this.decimalMarker === 'string' ? this.decimalMarker : "." /* MaskExpression.DOT */;
            return integerString === "" /* MaskExpression.EMPTY_STRING */
                ? "" /* MaskExpression.EMPTY_STRING */
                : integerString + decimal + decimalPart;
        }
    }
    static { this.ɵfac = i0.ɵɵngDeclareFactory({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskApplierService, deps: [], target: i0.ɵɵFactoryTarget.Injectable }); }
    static { this.ɵprov = i0.ɵɵngDeclareInjectable({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskApplierService }); }
}
i0.ɵɵngDeclareClassMetadata({ minVersion: "12.0.0", version: "16.2.12", ngImport: i0, type: NgxMaskApplierService, decorators: [{
            type: Injectable
        }] });
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibmd4LW1hc2stYXBwbGllci5zZXJ2aWNlLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vcHJvamVjdHMvbmd4LW1hc2stbGliL3NyYy9saWIvbmd4LW1hc2stYXBwbGllci5zZXJ2aWNlLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBLE9BQU8sRUFBRSxNQUFNLEVBQUUsVUFBVSxFQUFFLE1BQU0sZUFBZSxDQUFDO0FBQ25ELE9BQU8sRUFBRSxlQUFlLEVBQVcsTUFBTSxtQkFBbUIsQ0FBQzs7QUFJN0QsTUFBTSxPQUFPLHFCQUFxQjtJQURsQztRQUVjLFlBQU8sR0FBRyxNQUFNLENBQVUsZUFBZSxDQUFDLENBQUM7UUFFOUMsMEJBQXFCLEdBQ3hCLElBQUksQ0FBQyxPQUFPLENBQUMscUJBQXFCLENBQUM7UUFFaEMsZ0JBQVcsR0FBMkIsSUFBSSxDQUFDLE9BQU8sQ0FBQyxXQUFXLENBQUM7UUFJL0Qsb0JBQWUsR0FBK0IsSUFBSSxDQUFDLE9BQU8sQ0FBQyxlQUFlLENBQUM7UUFFM0Usc0JBQWlCLEdBQWlDLElBQUksQ0FBQyxPQUFPLENBQUMsaUJBQWlCLENBQUM7UUFFakYsYUFBUSxHQUF3QixJQUFJLENBQUMsT0FBTyxDQUFDLFFBQVEsQ0FBQztRQUV0RCxXQUFNLEdBQXNCLElBQUksQ0FBQyxPQUFPLENBQUMsTUFBTSxDQUFDO1FBRWhELFdBQU0sR0FBc0IsSUFBSSxDQUFDLE9BQU8sQ0FBQyxNQUFNLENBQUM7UUFFaEQsc0JBQWlCLEdBQWlDLElBQUksQ0FBQyxPQUFPLENBQUMsaUJBQWlCLENBQUM7UUFFakYsa0JBQWEsR0FBNkIsSUFBSSxDQUFDLE9BQU8sQ0FBQyxhQUFhLENBQUM7UUFJckUsa0JBQWEsR0FBNkIsSUFBSSxDQUFDLE9BQU8sQ0FBQyxhQUFhLENBQUM7UUFFckUseUJBQW9CLEdBQ3ZCLElBQUksQ0FBQyxPQUFPLENBQUMsb0JBQW9CLENBQUM7UUFFL0IsZUFBVSxHQUEwQixJQUFJLENBQUMs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QUNkLE9BQU8sSUFBSSxDQUFDLGFBQWEsS0FBSyxRQUFRO1lBQ2xDLENBQUMsQ0FBQyxLQUFLLENBQUMsT0FBTyxDQUFDLElBQUksQ0FBQyxhQUFhLENBQUM7WUFDbkMsQ0FBQyxDQUFDLEtBQUssQ0FBQyxPQUFPLDhCQUFvQixDQUFDO1FBQzVDLElBQUksWUFBWSxLQUFLLENBQUMsQ0FBQyxFQUFFO1lBQ3JCLE1BQU0sV0FBVyxHQUFHLFFBQVEsQ0FBQyxLQUFLLEVBQUUsRUFBRSxDQUFDLENBQUM7WUFDeEMsT0FBTyxLQUFLLENBQUMsV0FBVyxDQUFDLENBQUMsQ0FBQyxzQ0FBNkIsQ0FBQyxDQUFDLFdBQVcsQ0FBQyxRQUFRLEVBQUUsQ0FBQztTQUNwRjthQUFNO1lBQ0gsTUFBTSxXQUFXLEdBQUcsUUFBUSxDQUFDLEtBQUssQ0FBQyxTQUFTLENBQUMsQ0FBQyxFQUFFLFlBQVksQ0FBQyxFQUFFLEVBQUUsQ0FBQyxDQUFDO1lBQ25FLE1BQU0sV0FBVyxHQUFHLEtBQUssQ0FBQyxTQUFTLENBQUMsWUFBWSxHQUFHLENBQUMsQ0FBQyxDQUFDO1lBQ3RELE1BQU0sYUFBYSxHQUFHLEtBQUssQ0FBQyxXQUFXLENBQUMsQ0FBQyxDQUFDLENBQUMsRUFBRSxDQUFDLENBQUMsQ0FBQyxXQUFXLENBQUMsUUFBUSxFQUFFLENBQUM7WUFDdkUsTUFBTSxPQUFPLEdBQ1QsT0FBTyxJQUFJLENBQUMsYUFBYSxLQUFLLFFBQVEsQ0FBQyxDQUFDLENBQUMsSUFBSSxDQUFDLGFBQWEsQ0FBQyxDQUFDLDZCQUFtQixDQUFDO1lBQ3JGLE9BQU8sYUFBYSx5Q0FBZ0M7Z0JBQ2hELENBQUM7Z0JBQ0QsQ0FBQyxDQUFDLGFBQWEsR0FBRyxPQUFPLEdBQUcsV0FBVyxDQUFDO1NBQy9DO0lBQ0wsQ0FBQzsrR0EvNkJRLHFCQUFxQjttSEFBckIscUJBQXFCOzs0RkFBckIscUJBQXFCO2tCQURqQyxVQUFVIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IHsgaW5qZWN0LCBJbmplY3RhYmxlIH0gZnJvbSAnQGFuZ3VsYXIvY29yZSc7XG5pbXBvcnQgeyBOR1hfTUFTS19DT05GSUcsIElDb25maWcgfSBmcm9tICcuL25neC1tYXNrLmNvbmZpZyc7XG5pbXBvcnQgeyBNYXNrRXhwcmVzc2lvbiB9IGZyb20gJy4vbmd4LW1hc2stZXhwcmVzc2lvbi5lbnVtJztcblxuQEluamVjdGFibGUoKVxuZXhwb3J0IGNsYXNzIE5neE1hc2tBcHBsaWVyU2VydmljZSB7XG4gICAgcHJvdGVjdGVkIF9jb25maWcgPSBpbmplY3Q8SUNvbmZpZz4oTkdYX01BU0tfQ09ORklHKTtcblxuICAgIHB1YmxpYyBkcm9wU3BlY2lhbENoYXJhY3RlcnM6IElDb25maWdbJ2Ryb3BTcGVjaWFsQ2hhcmFjdGVycyddID1cbiAgICAgICAgdGhpcy5fY29uZmlnLmRyb3BTcGVjaWFsQ2hhcmFjdGVycztcblxuICAgIHB1YmxpYyBoaWRkZW5JbnB1dDogSUNvbmZpZ1snaGlkZGVuSW5wdXQnXSA9IHRoaXMuX2NvbmZpZy5oaWRkZW5JbnB1dDtcblxuICAgIHB1YmxpYyBzaG93VGVtcGxhdGUhOiBJQ29uZmlnWydzaG93VGVtcGxhdGUnXTtcblxuICAgIHB1YmxpYyBjbGVhcklmTm90TWF0Y2g6IElDb25maWdbJ2NsZWFySWZOb3RNYXRjaCddID0gdGhpcy5fY29uZmlnLmNsZWFySWZOb3RNYXRjaDtcblxuICAgIHB1YmxpYyBzcGVjaWFsQ2hhcmFjdGVyczogSUNvbmZpZ1snc3BlY2lhbENoYXJhY3RlcnMnXSA9IHRoaXMuX2NvbmZpZy5zcGVjaWFsQ2hhcmFjdGVycztcblxuICAgIHB1YmxpYyBwYXR0ZXJuczogSUNvbmZpZ1sncGF0dGVybnMnXSA9IHRoaXMuX2NvbmZpZy5wYXR0ZXJucztcblxuICAgIHB1YmxpYyBwcmVmaXg6IElDb25maWdbJ3ByZWZpeCddID0gdGhpcy5fY29uZmlnLnByZWZpeDtcblxuICAgIHB1YmxpYyBzdWZmaXg6IElDb25maWdbJ3N1ZmZpeCddID0gdGhpcy5fY29uZmlnLnN1ZmZpeDtcblxuICAgIHB1YmxpYyB0aG91c2FuZFNlcGFyYXRvcjogSUNvbmZpZ1sndGhvdXNhbmRTZXBhcmF0b3InXSA9IHRoaXMuX2NvbmZpZy50aG91c2FuZFNlcGFyYXRvcjtcblxuICAgIHB1YmxpYyBkZWNpbWFsTWFya2VyOiBJQ29uZmlnWydkZWNpbWFsTWFya2VyJ10gPSB0aGlzLl9jb25maWcuZGVjaW1hbE1hcmtlcjtcblxuICAgIHB1YmxpYyBjdXN0b21QYXR0ZXJuITogSUNvbmZpZ1sncGF0dGVybnMnXTtcblxuICAgIHB1YmxpYyBzaG93TWFza1R5cGVkOiBJQ29uZmlnWydzaG93TWFza1R5cGVkJ10gPSB0aGlzLl9jb25maWcuc2hvd01hc2tUeXBlZDtcblxuICAgIHB1YmxpYyBwbGFjZUhvbGRlckNoYXJhY3RlcjogSUNvbmZpZ1sncGxhY2VIb2xkZXJDaGFyYWN0ZXInXSA9XG4gICAgICAgIHRoaXMuX2NvbmZpZy5wbGFjZUhvbGRlckNoYXJhY3RlcjtcblxuICAgIHB1YmxpYyB2YWxpZGF0aW9uOiBJQ29uZmlnWyd2YWxpZGF0aW9uJ10gPSB0aGlzLl9jb25maWcudmFsaWRhdGlvbjtcblxuICAgIHB1YmxpYyBzZXBhcmF0b3JMaW1pdDogSUNvbmZpZ1snc2VwYXJhdG9yTGltaXQnXSA9IHRoaXMuX2NvbmZpZy5zZXBhcmF0b3JMaW1pdDtcblxuICAgIHB1YmxpYyBhbGxvd05lZ2F0aXZlTnVtYmVyczogSUNvbmZpZ1snYWxsb3dOZWdhdGl2ZU51bWJlcnMnXSA9XG4gICAgICAgIHRoaXMuX2NvbmZpZy5hbGxvd05lZ2F0aXZlTnVtYmVycztcblxuICAgIHB1YmxpYyBsZWFkWmVyb0RhdGVUaW1lOiBJQ29uZmlnWydsZWFkWmVyb0RhdGVUaW1lJ10gPSB0aGlzLl9jb25maWcubGVhZFplcm9EYXRlVGltZTtcblxuICAgIHB1YmxpYyBsZWFkWmVybzogSUNvbmZpZ1snbGVhZFplcm8nXSA9IHRoaXMuX2NvbmZpZy5sZWFkWmVybztcblxuICAgIHB1YmxpYyBhcG06IElDb25maWdbJ2FwbSddID0gdGhpcy5fY29uZmlnLmFwbTtcblxuICAgIHB1YmxpYyBpbnB1dFRyYW5zZm9ybUZuOiBJQ29uZmlnWydpbnB1dFRyYW5zZm9ybUZuJ10gPSB0aGlzLl9jb25maWcuaW5wdXRUcmFuc2Zvcm1GbjtcblxuICAgIHB1YmxpYyBvdXRwdXRUcmFuc2Zvcm1GbjogSUNvbmZpZ1snb3V0cHV0VHJhbnNmb3JtRm4nXSA9IHRoaXMuX2NvbmZpZy5vdXRwdXRUcmFuc2Zvcm1GbjtcblxuICAgIHB1YmxpYyBrZWVwQ2hhcmFjdGVyUG9zaXRpb25zOiBJQ29uZmlnWydrZWVwQ2hhcmFjdGVyUG9zaXRpb25zJ10gPVxuICAgICAgICB0aGlzLl9jb25maWcua2VlcENoYXJhY3RlclBvc2l0aW9ucztcblxuICAgIHByaXZhdGUgX3NoaWZ0OiBTZXQ8bnVtYmVyPiA9IG5ldyBTZXQoKTtcblxuICAgIHB1YmxpYyBwbHVzT25lUG9zaXRpb24gPSBmYWxzZTtcblxuICAgIHB1YmxpYyBtYXNrRXhwcmVzc2lvbiA9ICcnO1xuXG4gICAgcHVibGljIGFjdHVhbFZhbHVlID0gJyc7XG5cbiAgICBwdWJsaWMgc2hvd0tlZXBDaGFyYWN0ZXJFeHAgPSAnJztcblxuICAgIHB1YmxpYyBzaG93bk1hc2tFeHByZXNzaW9uID0gJyc7XG5cbiAgICBwdWJsaWMgZGVsZXRlZFNwZWNpYWxDaGFyYWN0ZXIgPSBmYWxzZTtcblxuICAgIHB1YmxpYyBpcEVycm9yPzogYm9vbGVhbjtcblxuICAgIHB1YmxpYyBjcGZDbnBqRXJyb3I/OiBib29sZWFuO1xuXG4gICAgcHVibGljIGFwcGx5TWFza1dpdGhQYXR0ZXJuKFxuICAgICAgICBpbnB1dFZhbHVlOiBzdHJpbmcsXG4gICAgICAgIG1hc2tBbmRQYXR0ZXJuOiBbc3RyaW5nLCBJQ29uZmlnWydwYXR0ZXJucyddXVxuICAgICk6IHN0cmluZyB7XG4gICAgICAgIGNvbnN0IFttYXNrLCBjdXN0b21QYXR0ZXJuXSA9IG1hc2tBbmRQYXR0ZXJuO1xuICAgICAgICB0aGlzLmN1c3RvbVBhdHRlcm4gPSBjdXN0b21QYXR0ZXJuO1xuICAgICAgICByZXR1cm4gdGhpcy5hcHBseU1hc2soaW5wdXRWYWx1ZSwgbWFzayk7XG4gICAgfVxuXG4gICAgcHVibGljIGFwcGx5TWFzayhcbiAgICAgICAgaW5wdXRWYWx1ZTogc3RyaW5nIHwgb2JqZWN0IHwgYm9vbGVhbiB8IG51bGwgfCB1bmRlZmluZWQsXG4gICAgICAgIG1hc2tFeHByZXNzaW9uOiBzdHJpbmcsXG4gICAgICAgIHBvc2l0aW9uID0gMCxcbiAgICAgICAganVzdFBhc3RlZCA9IGZhbHNlLFxuICAgICAgICBiYWNrc3BhY2VkID0gZmFsc2UsXG4gICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBAdHlwZXNjcmlwdC1lc2xpbnQvbm8tZW1wdHktZnVuY3Rpb24sIEB0eXBlc2NyaXB0LWVzbGludC9uby1leHBsaWNpdC1hbnlcbiAgICAgICAgY2I6ICguLi5hcmdzOiBhbnlbXSkgPT4gYW55ID0gKCkgPT4ge31cbiAgICApOiBzdHJpbmcge1xuICAgICAgICBpZiAoIW1hc2tFeHByZXNzaW9uIHx8IHR5cGVvZiBpbnB1dFZhbHVlICE9PSAnc3RyaW5nJykge1xuICAgICAgICAgICAgcmV0dXJuIE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORztcbiAgICAgICAgfVxuICAgICAgICBsZXQgY3Vyc29yID0gMDtcbiAgICAgICAgbGV0IHJlc3VsdCA9ICcnO1xuICAgICAgICBsZXQgbXVsdGkgPSBmYWxzZTtcbiAgICAgICAgbGV0IGJhY2tzcGFjZVNoaWZ0ID0gZmFsc2U7XG4gICAgICAgIGxldCBzaGlmdCA9IDE7XG4gICAgICAgIGxldCBzdGVwQmFjayA9IGZhbHNlO1xuICAgICAgICBpZiAoaW5wdXRWYWx1ZS5zbGljZSgwLCB0aGlzLnByZWZpeC5sZW5ndGgpID09PSB0aGlzLnByZWZpeCkge1xuICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICBpbnB1dFZhbHVlID0gaW5wdXRWYWx1ZS5zbGljZSh0aGlzLnByZWZpeC5sZW5ndGgsIGlucHV0VmFsdWUubGVuZ3RoKTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoISF0aGlzLnN1ZmZpeCAmJiBpbnB1dFZhbHVlPy5sZW5ndGggPiAwKSB7XG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgIGlucHV0VmFsdWUgPSB0aGlzLmNoZWNrQW5kUmVtb3ZlU3VmZml4KGlucHV0VmFsdWUpO1xuICAgICAgICB9XG4gICAgICAgIGlmIChpbnB1dFZhbHVlID09PSAnKCcgJiYgdGhpcy5wcmVmaXgpIHtcbiAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgaW5wdXRWYWx1ZSA9ICcnO1xuICAgICAgICB9XG4gICAgICAgIGNvbnN0IGlucHV0QXJyYXk6IHN0cmluZ1tdID0gaW5wdXRWYWx1ZS50b1N0cmluZygpLnNwbGl0KE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORyk7XG4gICAgICAgIGlmIChcbiAgICAgICAgICAgIHRoaXMuYWxsb3dOZWdhdGl2ZU51bWJlcnMgJiZcbiAgICAgICAgICAgIGlucHV0VmFsdWUuc2xpY2UoY3Vyc29yLCBjdXJzb3IgKyAxKSA9PT0gTWFza0V4cHJlc3Npb24uTUlOVVNcbiAgICAgICAgKSB7XG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgIHJlc3VsdCArPSBpbnB1dFZhbHVlLnNsaWNlKGN1cnNvciwgY3Vyc29yICsgMSk7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKG1hc2tFeHByZXNzaW9uID09PSBNYXNrRXhwcmVzc2lvbi5JUCkge1xuICAgICAgICAgICAgY29uc3QgdmFsdWVzSVAgPSBpbnB1dFZhbHVlLnNwbGl0KE1hc2tFeHByZXNzaW9uLkRPVCk7XG4gICAgICAgICAgICB0aGlzLmlwRXJyb3IgPSB0aGlzLl92YWxpZElQKHZhbHVlc0lQKTtcbiAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgbWFza0V4cHJlc3Npb24gPSAnMDk5LjA5OS4wOTkuMDk5JztcbiAgICAgICAgfVxuICAgICAgICBjb25zdCBhcnI6IHN0cmluZ1tdID0gW107XG4gICAgICAgIGZvciAobGV0IGkgPSAwOyBpIDwgaW5wdXRWYWx1ZS5sZW5ndGg7IGkrKykge1xuICAgICAgICAgICAgaWYgKGlucHV0VmFsdWVbaV0/Lm1hdGNoKCdcXFxcZCcpKSB7XG4gICAgICAgICAgICAgICAgYXJyLnB1c2goaW5wdXRWYWx1ZVtpXSA/PyBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkcpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIGlmIChtYXNrRXhwcmVzc2lvbiA9PT0gTWFza0V4cHJlc3Npb24uQ1BGX0NOUEopIHtcbiAgICAgICAgICAgIHRoaXMuY3BmQ25wakVycm9yID0gYXJyLmxlbmd0aCAhPT0gMTEgJiYgYXJyLmxlbmd0aCAhPT0gMTQ7XG4gICAgICAgICAgICBpZiAoYXJyLmxlbmd0aCA+IDExKSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb24gPSAnMDAuMDAwLjAwMC8wMDAwLTAwJztcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb24gPSAnMDAwLjAwMC4wMDAtMDAnO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIGlmIChtYXNrRXhwcmVzc2lvbi5zdGFydHNXaXRoKE1hc2tFeHByZXNzaW9uLlBFUkNFTlQpKSB7XG4gICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZS5tYXRjaCgnW2Etel18W0EtWl0nKSB8fFxuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby11c2VsZXNzLWVzY2FwZVxuICAgICAgICAgICAgICAgIChpbnB1dFZhbHVlLm1hdGNoKC9bLSEkJV4mKigpXyt8fj1ge31cXFtcXF06XCI7Jzw+PyxcXC8uXS8pICYmICFiYWNrc3BhY2VkKVxuICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IHRoaXMuX3N0cmlwVG9EZWNpbWFsKGlucHV0VmFsdWUpO1xuICAgICAgICAgICAgICAgIGNvbnN0IHByZWNpc2lvbjogbnVtYmVyID0gdGhpcy5nZXRQcmVjaXNpb24obWFza0V4cHJlc3Npb24pO1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPSB0aGlzLmNoZWNrSW5wdXRQcmVjaXNpb24oaW5wdXRWYWx1ZSwgcHJlY2lzaW9uLCB0aGlzLmRlY2ltYWxNYXJrZXIpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgY29uc3QgZGVjaW1hbE1hcmtlciA9XG4gICAgICAgICAgICAgICAgdHlwZW9mIHRoaXMuZGVjaW1hbE1hcmtlciA9PT0gJ3N0cmluZycgPyB0aGlzLmRlY2ltYWxNYXJrZXIgOiBNYXNrRXhwcmVzc2lvbi5ET1Q7XG4gICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZS5pbmRleE9mKGRlY2ltYWxNYXJrZXIpID4gMCAmJlxuICAgICAgICAgICAgICAgICF0aGlzLnBlcmNlbnRhZ2UoaW5wdXRWYWx1ZS5zdWJzdHJpbmcoMCwgaW5wdXRWYWx1ZS5pbmRleE9mKGRlY2ltYWxNYXJrZXIpKSlcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIGxldCBiYXNlOiBzdHJpbmcgPSBpbnB1dFZhbHVlLnN1YnN0cmluZygwLCBpbnB1dFZhbHVlLmluZGV4T2YoZGVjaW1hbE1hcmtlcikgLSAxKTtcbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuYWxsb3dOZWdhdGl2ZU51bWJlcnMgJiZcbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZS5zbGljZShjdXJzb3IsIGN1cnNvciArIDEpID09PSBNYXNrRXhwcmVzc2lvbi5NSU5VUyAmJlxuICAgICAgICAgICAgICAgICAgICAhYmFja3NwYWNlZFxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICBiYXNlID0gaW5wdXRWYWx1ZS5zdWJzdHJpbmcoMCwgaW5wdXRWYWx1ZS5pbmRleE9mKGRlY2ltYWxNYXJrZXIpKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IGAke2Jhc2V9JHtpbnB1dFZhbHVlLnN1YnN0cmluZyhcbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZS5pbmRleE9mKGRlY2ltYWxNYXJrZXIpLFxuICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLmxlbmd0aFxuICAgICAgICAgICAgICAgICl9YDtcbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgbGV0IHZhbHVlID0gJyc7XG4gICAgICAgICAgICB0aGlzLmFsbG93TmVnYXRpdmVOdW1iZXJzICYmXG4gICAgICAgICAgICBpbnB1dFZhbHVlLnNsaWNlKGN1cnNvciwgY3Vyc29yICsgMSkgPT09IE1hc2tFeHByZXNzaW9uLk1JTlVTXG4gICAgICAgICAgICAgICAgPyAodmFsdWUgPSBpbnB1dFZhbHVlLnNsaWNlKGN1cnNvciArIDEsIGN1cnNvciArIGlucHV0VmFsdWUubGVuZ3RoKSlcbiAgICAgICAgICAgICAgICA6ICh2YWx1ZSA9IGlucHV0VmFsdWUpO1xuICAgICAgICAgICAgaWYgKHRoaXMucGVyY2VudGFnZSh2YWx1ZSkpIHtcbiAgICAgICAgICAgICAgICByZXN1bHQgPSB0aGlzLl9zcGxpdFBlcmNlbnRaZXJvKGlucHV0VmFsdWUpO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICByZXN1bHQgPSB0aGlzLl9zcGxpdFBlcmNlbnRaZXJvKGlucHV0VmFsdWUuc3Vic3RyaW5nKDAsIGlucHV0VmFsdWUubGVuZ3RoIC0gMSkpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9IGVsc2UgaWYgKG1hc2tFeHByZXNzaW9uLnN0YXJ0c1dpdGgoTWFza0V4cHJlc3Npb24uU0VQQVJBVE9SKSkge1xuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUubWF0Y2goJ1t30LAt0Y/QkC3Qr10nKSB8fFxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUubWF0Y2goJ1vQgdGR0JAt0Y9dJykgfHxcbiAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLm1hdGNoKCdbYS16XXxbQS1aXScpIHx8XG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZS5tYXRjaCgvWy1AIyEkJVxcXFxeJiooKV/Co8KsJyt8fj1ge31cXF06XCI7PD4uPy9dLykgfHxcbiAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLm1hdGNoKCdbXkEtWmEtejAtOSxdJylcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPSB0aGlzLl9zdHJpcFRvRGVjaW1hbChpbnB1dFZhbHVlKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIGNvbnN0IHByZWNpc2lvbjogbnVtYmVyID0gdGhpcy5nZXRQcmVjaXNpb24obWFza0V4cHJlc3Npb24pO1xuICAgICAgICAgICAgY29uc3QgZGVjaW1hbE1hcmtlciA9IEFycmF5LmlzQXJyYXkodGhpcy5kZWNpbWFsTWFya2VyKVxuICAgICAgICAgICAgICAgID8gTWFza0V4cHJlc3Npb24uRE9UXG4gICAgICAgICAgICAgICAgOiB0aGlzLmRlY2ltYWxNYXJrZXI7XG4gICAgICAgICAgICBpZiAocHJlY2lzaW9uID09PSAwKSB7XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IHRoaXMuYWxsb3dOZWdhdGl2ZU51bWJlcnNcbiAgICAgICAgICAgICAgICAgICAgPyBpbnB1dFZhbHVlLmxlbmd0aCA+IDIgJiZcbiAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlWzBdID09PSBNYXNrRXhwcmVzc2lvbi5NSU5VUyAmJlxuICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMV0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICYmXG4gICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVsyXSAhPT0gdGhpcy50aG91c2FuZFNlcGFyYXRvciAmJlxuICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMl0gIT09IE1hc2tFeHByZXNzaW9uLkNPTU1BICYmXG4gICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVsyXSAhPT0gTWFza0V4cHJlc3Npb24uRE9UXG4gICAgICAgICAgICAgICAgICAgICAgICA/ICctJyArIGlucHV0VmFsdWUuc2xpY2UoMiwgaW5wdXRWYWx1ZS5sZW5ndGgpXG4gICAgICAgICAgICAgICAgICAgICAgICA6IGlucHV0VmFsdWVbMF0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWUubGVuZ3RoID4gMSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlWzFdICE9PSB0aGlzLnRob3VzYW5kU2VwYXJhdG9yICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMV0gIT09IE1hc2tFeHByZXNzaW9uLkNPTU1BICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMV0gIT09IE1hc2tFeHByZXNzaW9uLkRPVFxuICAgICAgICAgICAgICAgICAgICAgICAgPyBpbnB1dFZhbHVlLnNsaWNlKDEsIGlucHV0VmFsdWUubGVuZ3RoKVxuICAgICAgICAgICAgICAgICAgICAgICAgOiBpbnB1dFZhbHVlXG4gICAgICAgICAgICAgICAgICAgIDogaW5wdXRWYWx1ZS5sZW5ndGggPiAxICYmXG4gICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVswXSA9PT0gTWFza0V4cHJlc3Npb24uTlVNQkVSX1pFUk8gJiZcbiAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlWzFdICE9PSB0aGlzLnRob3VzYW5kU2VwYXJhdG9yICYmXG4gICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVsxXSAhPT0gTWFza0V4cHJlc3Npb24uQ09NTUEgJiZcbiAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlWzFdICE9PSBNYXNrRXhwcmVzc2lvbi5ET1RcbiAgICAgICAgICAgICAgICAgICAgPyBpbnB1dFZhbHVlLnNsaWNlKDEsIGlucHV0VmFsdWUubGVuZ3RoKVxuICAgICAgICAgICAgICAgICAgICA6IGlucHV0VmFsdWU7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGlmIChpbnB1dFZhbHVlWzBdID09PSBkZWNpbWFsTWFya2VyICYmIGlucHV0VmFsdWUubGVuZ3RoID4gMSkge1xuICAgICAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICBNYXNrRXhwcmVzc2lvbi5OVU1CRVJfWkVSTyArIGlucHV0VmFsdWUuc2xpY2UoMCwgaW5wdXRWYWx1ZS5sZW5ndGggKyAxKTtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5wbHVzT25lUG9zaXRpb24gPSB0cnVlO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMF0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICYmXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMV0gIT09IGRlY2ltYWxNYXJrZXIgJiZcbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVsxXSAhPT0gdGhpcy50aG91c2FuZFNlcGFyYXRvclxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9XG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLmxlbmd0aCA+IDFcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICA/IGlucHV0VmFsdWUuc2xpY2UoMCwgMSkgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVjaW1hbE1hcmtlciArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLnNsaWNlKDEsIGlucHV0VmFsdWUubGVuZ3RoICsgMSlcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGlucHV0VmFsdWU7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMucGx1c09uZVBvc2l0aW9uID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLmFsbG93TmVnYXRpdmVOdW1iZXJzICYmXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMF0gPT09IE1hc2tFeHByZXNzaW9uLk1JTlVTICYmXG4gICAgICAgICAgICAgICAgICAgIChpbnB1dFZhbHVlWzFdID09PSBkZWNpbWFsTWFya2VyIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlWzFdID09PSBNYXNrRXhwcmVzc2lvbi5OVU1CRVJfWkVSTylcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPVxuICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVsxXSA9PT0gZGVjaW1hbE1hcmtlciAmJiBpbnB1dFZhbHVlLmxlbmd0aCA+IDJcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICA/IGlucHV0VmFsdWUuc2xpY2UoMCwgMSkgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWFza0V4cHJlc3Npb24uTlVNQkVSX1pFUk8gK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZS5zbGljZSgxLCBpbnB1dFZhbHVlLmxlbmd0aClcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGlucHV0VmFsdWVbMV0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLmxlbmd0aCA+IDIgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMl0gIT09IGRlY2ltYWxNYXJrZXJcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICA/IGlucHV0VmFsdWUuc2xpY2UoMCwgMikgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVjaW1hbE1hcmtlciArXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlLnNsaWNlKDIsIGlucHV0VmFsdWUubGVuZ3RoKVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogaW5wdXRWYWx1ZTtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5wbHVzT25lUG9zaXRpb24gPSB0cnVlO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgaWYgKGJhY2tzcGFjZWQpIHtcbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMF0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICYmXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMV0gPT09IHRoaXMuZGVjaW1hbE1hcmtlciAmJlxuICAgICAgICAgICAgICAgICAgICAoaW5wdXRWYWx1ZVtwb3NpdGlvbl0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlW3Bvc2l0aW9uXSA9PT0gdGhpcy5kZWNpbWFsTWFya2VyKVxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IGlucHV0VmFsdWUuc2xpY2UoMiwgaW5wdXRWYWx1ZS5sZW5ndGgpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMF0gPT09IE1hc2tFeHByZXNzaW9uLk1JTlVTICYmXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMV0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICYmXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbMl0gPT09IHRoaXMuZGVjaW1hbE1hcmtlciAmJlxuICAgICAgICAgICAgICAgICAgICAoaW5wdXRWYWx1ZVtwb3NpdGlvbl0gPT09IE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlW3Bvc2l0aW9uXSA9PT0gdGhpcy5kZWNpbWFsTWFya2VyKVxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IE1hc2tFeHByZXNzaW9uLk1JTlVTICsgaW5wdXRWYWx1ZS5zbGljZSgzLCBpbnB1dFZhbHVlLmxlbmd0aCk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPSB0aGlzLl9jb21wYXJlT3JJbmNsdWRlcyhcbiAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVtpbnB1dFZhbHVlLmxlbmd0aCAtIDFdLFxuICAgICAgICAgICAgICAgICAgICB0aGlzLmRlY2ltYWxNYXJrZXIsXG4gICAgICAgICAgICAgICAgICAgIHRoaXMudGhvdXNhbmRTZXBhcmF0b3JcbiAgICAgICAgICAgICAgICApXG4gICAgICAgICAgICAgICAgICAgID8gaW5wdXRWYWx1ZS5zbGljZSgwLCBpbnB1dFZhbHVlLmxlbmd0aCAtIDEpXG4gICAgICAgICAgICAgICAgICAgIDogaW5wdXRWYWx1ZTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIC8vIFRPRE86IHdlIGhhZCBkaWZmZXJlbnQgcmV4ZXhwcyBoZXJlIGZvciB0aGUgZGlmZmVyZW50IGNhc2VzLi4uIGJ1dCB0ZXN0cyBkb250IHNlYW0gdG8gYm90aGVyIC0gY2hlY2sgdGhpc1xuICAgICAgICAgICAgLy8gIHNlcGFyYXRvcjogbm8gQ09NTUEsIGRvdC1zZXA6IG5vIFNQQUNFLCBDT01NQSBPSywgY29tbWEtc2VwOiBubyBTUEFDRSwgQ09NTUEgT0tcblxuICAgICAgICAgICAgY29uc3QgdGhvdXNhbmRTZXBhcmF0b3JDaGFyRXNjYXBlZDogc3RyaW5nID0gdGhpcy5fY2hhclRvUmVnRXhwRXhwcmVzc2lvbihcbiAgICAgICAgICAgICAgICB0aGlzLnRob3VzYW5kU2VwYXJhdG9yXG4gICAgICAgICAgICApO1xuICAgICAgICAgICAgbGV0IGludmFsaWRDaGFyczogc3RyaW5nID0gJ0AjISQlXiYqKClfK3x+PWB7fVxcXFxbXFxcXF06XFxcXHMsXFxcXC5cIjs8Pj9cXFxcLycucmVwbGFjZShcbiAgICAgICAgICAgICAgICB0aG91c2FuZFNlcGFyYXRvckNoYXJFc2NhcGVkLFxuICAgICAgICAgICAgICAgICcnXG4gICAgICAgICAgICApO1xuICAgICAgICAgICAgLy8ucmVwbGFjZShkZWNpbWFsTWFya2VyRXNjYXBlZCwgJycpO1xuICAgICAgICAgICAgaWYgKEFycmF5LmlzQXJyYXkodGhpcy5kZWNpbWFsTWFya2VyKSkge1xuICAgICAgICAgICAgICAgIGZvciAoY29uc3QgbWFya2VyIG9mIHRoaXMuZGVjaW1hbE1hcmtlcikge1xuICAgICAgICAgICAgICAgICAgICBpbnZhbGlkQ2hhcnMgPSBpbnZhbGlkQ2hhcnMucmVwbGFjZShcbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX2NoYXJUb1JlZ0V4cEV4cHJlc3Npb24obWFya2VyKSxcbiAgICAgICAgICAgICAgICAgICAgICAgIE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgICAgICAgICApO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgaW52YWxpZENoYXJzID0gaW52YWxpZENoYXJzLnJlcGxhY2UoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX2NoYXJUb1JlZ0V4cEV4cHJlc3Npb24odGhpcy5kZWNpbWFsTWFya2VyKSxcbiAgICAgICAgICAgICAgICAgICAgJydcbiAgICAgICAgICAgICAgICApO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICBjb25zdCBpbnZhbGlkQ2hhclJlZ2V4cCA9IG5ldyBSZWdFeHAoJ1snICsgaW52YWxpZENoYXJzICsgJ10nKTtcbiAgICAgICAgICAgIGlmIChpbnB1dFZhbHVlLm1hdGNoKGludmFsaWRDaGFyUmVnZXhwKSkge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPSBpbnB1dFZhbHVlLnN1YnN0cmluZygwLCBpbnB1dFZhbHVlLmxlbmd0aCAtIDEpO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgIGlucHV0VmFsdWUgPSB0aGlzLmNoZWNrSW5wdXRQcmVjaXNpb24oaW5wdXRWYWx1ZSwgcHJlY2lzaW9uLCB0aGlzLmRlY2ltYWxNYXJrZXIpO1xuICAgICAgICAgICAgY29uc3Qgc3RyRm9yU2VwOiBzdHJpbmcgPSBpbnB1dFZhbHVlLnJlcGxhY2UoXG4gICAgICAgICAgICAgICAgbmV3IFJlZ0V4cCh0aG91c2FuZFNlcGFyYXRvckNoYXJFc2NhcGVkLCAnZycpLFxuICAgICAgICAgICAgICAgICcnXG4gICAgICAgICAgICApO1xuXG4gICAgICAgICAgICByZXN1bHQgPSB0aGlzLl9mb3JtYXRXaXRoU2VwYXJhdG9ycyhcbiAgICAgICAgICAgICAgICBzdHJGb3JTZXAsXG4gICAgICAgICAgICAgICAgdGhpcy50aG91c2FuZFNlcGFyYXRvcixcbiAgICAgICAgICAgICAgICB0aGlzLmRlY2ltYWxNYXJrZXIsXG4gICAgICAgICAgICAgICAgcHJlY2lzaW9uXG4gICAgICAgICAgICApO1xuXG4gICAgICAgICAgICBjb25zdCBjb21tYVNoaWZ0OiBudW1iZXIgPVxuICAgICAgICAgICAgICAgIHJlc3VsdC5pbmRleE9mKE1hc2tFeHByZXNzaW9uLkNPTU1BKSAtIGlucHV0VmFsdWUuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5DT01NQSk7XG4gICAgICAgICAgICBjb25zdCBzaGlmdFN0ZXA6IG51bWJlciA9IHJlc3VsdC5sZW5ndGggLSBpbnB1dFZhbHVlLmxlbmd0aDtcblxuICAgICAgICAgICAgaWYgKHNoaWZ0U3RlcCA+IDAgJiYgcmVzdWx0W3Bvc2l0aW9uXSAhPT0gdGhpcy50aG91c2FuZFNlcGFyYXRvcikge1xuICAgICAgICAgICAgICAgIGJhY2tzcGFjZVNoaWZ0ID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICBsZXQgX3NoaWZ0ID0gMDtcbiAgICAgICAgICAgICAgICBkbyB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX3NoaWZ0LmFkZChwb3NpdGlvbiArIF9zaGlmdCk7XG4gICAgICAgICAgICAgICAgICAgIF9zaGlmdCsrO1xuICAgICAgICAgICAgICAgIH0gd2hpbGUgKF9zaGlmdCA8IHNoaWZ0U3RlcCk7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgIHJlc3VsdFtwb3NpdGlvbiAtIDFdID09PSB0aGlzLmRlY2ltYWxNYXJrZXIgfHxcbiAgICAgICAgICAgICAgICBzaGlmdFN0ZXAgPT09IC00IHx8XG4gICAgICAgICAgICAgICAgc2hpZnRTdGVwID09PSAtMyB8fFxuICAgICAgICAgICAgICAgIHJlc3VsdFtwb3NpdGlvbl0gPT09IE1hc2tFeHByZXNzaW9uLkNPTU1BXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9zaGlmdC5jbGVhcigpO1xuICAgICAgICAgICAgICAgIHRoaXMuX3NoaWZ0LmFkZChwb3NpdGlvbiAtIDEpO1xuICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAoY29tbWFTaGlmdCAhPT0gMCAmJlxuICAgICAgICAgICAgICAgICAgICBwb3NpdGlvbiA+IDAgJiZcbiAgICAgICAgICAgICAgICAgICAgIShyZXN1bHQuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5DT01NQSkgPj0gcG9zaXRpb24gJiYgcG9zaXRpb24gPiAzKSkgfHxcbiAgICAgICAgICAgICAgICAoIShyZXN1bHQuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5ET1QpID49IHBvc2l0aW9uICYmIHBvc2l0aW9uID4gMykgJiZcbiAgICAgICAgICAgICAgICAgICAgc2hpZnRTdGVwIDw9IDApXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICB0aGlzLl9zaGlmdC5jbGVhcigpO1xuICAgICAgICAgICAgICAgIGJhY2tzcGFjZVNoaWZ0ID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICBzaGlmdCA9IHNoaWZ0U3RlcDtcbiAgICAgICAgICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgICAgICAgICAgICBwb3NpdGlvbiArPSBzaGlmdFN0ZXA7XG4gICAgICAgICAgICAgICAgdGhpcy5fc2hpZnQuYWRkKHBvc2l0aW9uKTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgdGhpcy5fc2hpZnQuY2xlYXIoKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIGZvciAoXG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lXG4gICAgICAgICAgICAgICAgbGV0IGk6IG51bWJlciA9IDAsIGlucHV0U3ltYm9sOiBzdHJpbmcgPSBpbnB1dEFycmF5WzBdITtcbiAgICAgICAgICAgICAgICBpIDwgaW5wdXRBcnJheS5sZW5ndGg7XG4gICAgICAgICAgICAgICAgaSsrLCBpbnB1dFN5bWJvbCA9IGlucHV0QXJyYXlbaV0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICBpZiAoY3Vyc29yID09PSBtYXNrRXhwcmVzc2lvbi5sZW5ndGgpIHtcbiAgICAgICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgY29uc3Qgc3ltYm9sU3RhckluUGF0dGVybjogYm9vbGVhbiA9IE1hc2tFeHByZXNzaW9uLlNZTUJPTF9TVEFSIGluIHRoaXMucGF0dGVybnM7XG4gICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9jaGVja1N5bWJvbE1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFN5bWJvbCxcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uW2N1cnNvcl0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICAgICAgICAgICkgJiZcbiAgICAgICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bY3Vyc29yICsgMV0gPT09IE1hc2tFeHByZXNzaW9uLlNZTUJPTF9RVUVTVElPTlxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICByZXN1bHQgKz0gaW5wdXRTeW1ib2w7XG4gICAgICAgICAgICAgICAgICAgIGN1cnNvciArPSAyO1xuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoXG4gICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uW2N1cnNvciArIDFdID09PSBNYXNrRXhwcmVzc2lvbi5TWU1CT0xfU1RBUiAmJlxuICAgICAgICAgICAgICAgICAgICBtdWx0aSAmJlxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9jaGVja1N5bWJvbE1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFN5bWJvbCxcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uW2N1cnNvciArIDJdID8/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgICAgICAgICApXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIHJlc3VsdCArPSBpbnB1dFN5bWJvbDtcbiAgICAgICAgICAgICAgICAgICAgY3Vyc29yICs9IDM7XG4gICAgICAgICAgICAgICAgICAgIG11bHRpID0gZmFsc2U7XG4gICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fY2hlY2tTeW1ib2xNYXNrKFxuICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXRTeW1ib2wsXG4gICAgICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbltjdXJzb3JdID8/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgICAgICAgICApICYmXG4gICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uW2N1cnNvciArIDFdID09PSBNYXNrRXhwcmVzc2lvbi5TWU1CT0xfU1RBUiAmJlxuICAgICAgICAgICAgICAgICAgICAhc3ltYm9sU3RhckluUGF0dGVyblxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICByZXN1bHQgKz0gaW5wdXRTeW1ib2w7XG4gICAgICAgICAgICAgICAgICAgIG11bHRpID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbltjdXJzb3IgKyAxXSA9PT0gTWFza0V4cHJlc3Npb24uU1lNQk9MX1FVRVNUSU9OICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX2NoZWNrU3ltYm9sTWFzayhcbiAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0U3ltYm9sLFxuICAgICAgICAgICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bY3Vyc29yICsgMl0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICAgICAgICAgIClcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgcmVzdWx0ICs9IGlucHV0U3ltYm9sO1xuICAgICAgICAgICAgICAgICAgICBjdXJzb3IgKz0gMztcbiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9jaGVja1N5bWJvbE1hc2soXG4gICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFN5bWJvbCxcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uW2N1cnNvcl0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICAgICAgICAgIClcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgaWYgKG1hc2tFeHByZXNzaW9uW2N1cnNvcl0gPT09IE1hc2tFeHByZXNzaW9uLkhPVVJTKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBpZiAodGhpcy5hcG0gPyBOdW1iZXIoaW5wdXRTeW1ib2wpID4gOSA6IE51bWJlcihpbnB1dFN5bWJvbCkgPiAyKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zaXRpb24gPSAhdGhpcy5sZWFkWmVyb0RhdGVUaW1lID8gcG9zaXRpb24gKyAxIDogcG9zaXRpb247XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Vyc29yICs9IDE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fc2hpZnRTdGVwKG1hc2tFeHByZXNzaW9uLCBjdXJzb3IsIGlucHV0QXJyYXkubGVuZ3RoKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpLS07XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHRoaXMubGVhZFplcm9EYXRlVGltZSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHQgKz0gJzAnO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTtcbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICBpZiAobWFza0V4cHJlc3Npb25bY3Vyc29yXSA9PT0gTWFza0V4cHJlc3Npb24uSE9VUikge1xuICAgICAgICAgICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuYXBtXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID8gKHJlc3VsdC5sZW5ndGggPT09IDEgJiYgTnVtYmVyKHJlc3VsdCkgPiAxKSB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChyZXN1bHQgPT09ICcxJyAmJiBOdW1iZXIoaW5wdXRTeW1ib2wpID4gMikgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoaW5wdXRWYWx1ZS5zbGljZShjdXJzb3IgLSAxLCBjdXJzb3IpLmxlbmd0aCA9PT0gMSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOdW1iZXIoaW5wdXRWYWx1ZS5zbGljZShjdXJzb3IgLSAxLCBjdXJzb3IpKSA+IDIpIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGlucHV0VmFsdWUuc2xpY2UoY3Vyc29yIC0gMSwgY3Vyc29yKSA9PT0gJzEnICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE51bWJlcihpbnB1dFN5bWJvbCkgPiAyKVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IChyZXN1bHQgPT09ICcyJyAmJiBOdW1iZXIoaW5wdXRTeW1ib2wpID4gMykgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKHJlc3VsdC5zbGljZShjdXJzb3IgLSAyLCBjdXJzb3IpID09PSAnMicgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzdWx0LnNsaWNlKGN1cnNvciAtIDMsIGN1cnNvcikgPT09ICcyJyB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHQuc2xpY2UoY3Vyc29yIC0gNCwgY3Vyc29yKSA9PT0gJzInIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdC5zbGljZShjdXJzb3IgLSAxLCBjdXJzb3IpID09PSAnMicpICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE51bWJlcihpbnB1dFN5bWJvbCkgPiAzICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cnNvciA+IDEwKVxuICAgICAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zaXRpb24gPSBwb3NpdGlvbiArIDE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Vyc29yICs9IDE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaS0tO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlO1xuICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uW2N1cnNvcl0gPT09IE1hc2tFeHByZXNzaW9uLk1JTlVURSB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bY3Vyc29yXSA9PT0gTWFza0V4cHJlc3Npb24uU0VDT05EXG4gICAgICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgaWYgKE51bWJlcihpbnB1dFN5bWJvbCkgPiA1KSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zaXRpb24gPSAhdGhpcy5sZWFkWmVyb0RhdGVUaW1lID8gcG9zaXRpb24gKyAxIDogcG9zaXRpb247XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Vyc29yICs9IDE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5fc2hpZnRTdGVwKG1hc2tFeHByZXNzaW9uLCBjdXJzb3IsIGlucHV0QXJyYXkubGVuZ3RoKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpLS07XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHRoaXMubGVhZFplcm9EYXRlVGltZSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHQgKz0gJzAnO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTtcbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICBjb25zdCBkYXlzQ291bnQgPSAzMTtcbiAgICAgICAgICAgICAgICAgICAgY29uc3QgaW5wdXRWYWx1ZUN1cnNvciA9IGlucHV0VmFsdWVbY3Vyc29yXSBhcyBzdHJpbmc7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0VmFsdWVDdXJzb3JQbHVzT25lID0gaW5wdXRWYWx1ZVtjdXJzb3IgKyAxXSBhcyBzdHJpbmc7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0VmFsdWVDdXJzb3JQbHVzVHdvID0gaW5wdXRWYWx1ZVtjdXJzb3IgKyAyXSBhcyBzdHJpbmc7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0VmFsdWVDdXJzb3JNaW51c09uZSA9IGlucHV0VmFsdWVbY3Vyc29yIC0gMV0gYXMgc3RyaW5nO1xuICAgICAgICAgICAgICAgICAgICBjb25zdCBpbnB1dFZhbHVlQ3Vyc29yTWludXNUd28gPSBpbnB1dFZhbHVlW2N1cnNvciAtIDJdIGFzIHN0cmluZztcbiAgICAgICAgICAgICAgICAgICAgY29uc3QgaW5wdXRWYWx1ZUN1cnNvck1pbnVzVGhyZWUgPSBpbnB1dFZhbHVlW2N1cnNvciAtIDNdIGFzIHN0cmluZztcbiAgICAgICAgICAgICAgICAgICAgY29uc3QgaW5wdXRWYWx1ZVNsaWNlTWludXNUaHJlZU1pbnVzT25lID0gaW5wdXRWYWx1ZS5zbGljZShcbiAgICAgICAgICAgICAgICAgICAgICAgIGN1cnNvciAtIDMsXG4gICAgICAgICAgICAgICAgICAgICAgICBjdXJzb3IgLSAxXG4gICAgICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0VmFsdWVTbGljZU1pbnVzT25lUGx1c09uZSA9IGlucHV0VmFsdWUuc2xpY2UoY3Vyc29yIC0gMSwgY3Vyc29yICsgMSk7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0VmFsdWVTbGljZUN1cnNvclBsdXNUd28gPSBpbnB1dFZhbHVlLnNsaWNlKGN1cnNvciwgY3Vyc29yICsgMik7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGlucHV0VmFsdWVTbGljZU1pbnVzVHdvQ3Vyc29yID0gaW5wdXRWYWx1ZS5zbGljZShjdXJzb3IgLSAyLCBjdXJzb3IpO1xuICAgICAgICAgICAgICAgICAgICBpZiAobWFza0V4cHJlc3Npb25bY3Vyc29yXSA9PT0gTWFza0V4cHJlc3Npb24uREFZKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBtYXNrU3RhcnRXaXRoTW9udGggPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uLnNsaWNlKDAsIDIpID09PSBNYXNrRXhwcmVzc2lvbi5NT05USFM7XG4gICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdGFydFdpdGhNb250aElucHV0OiBib29sZWFuID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbi5zbGljZSgwLCAyKSA9PT0gTWFza0V4cHJlc3Npb24uTU9OVEhTICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmNsdWRlcyhpbnB1dFZhbHVlQ3Vyc29yTWludXNUd28pO1xuICAgICAgICAgICAgICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIChOdW1iZXIoaW5wdXRTeW1ib2wpID4gMyAmJiB0aGlzLmxlYWRaZXJvRGF0ZVRpbWUpIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgKCFtYXNrU3RhcnRXaXRoTW9udGggJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKE51bWJlcihpbnB1dFZhbHVlU2xpY2VDdXJzb3JQbHVzVHdvKSA+IGRheXNDb3VudCB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTnVtYmVyKGlucHV0VmFsdWVTbGljZU1pbnVzT25lUGx1c09uZSkgPiBkYXlzQ291bnQgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvclBsdXNPbmUpKSkgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3RhcnRXaXRoTW9udGhJbnB1dFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA/IE51bWJlcihpbnB1dFZhbHVlU2xpY2VNaW51c09uZVBsdXNPbmUpID4gZGF5c0NvdW50IHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCF0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKGlucHV0VmFsdWVDdXJzb3IpICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvclBsdXNUd28pKSB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvcilcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBOdW1iZXIoaW5wdXRWYWx1ZVNsaWNlQ3Vyc29yUGx1c1R3bykgPiBkYXlzQ291bnQgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKGlucHV0VmFsdWVDdXJzb3JQbHVzT25lKSlcbiAgICAgICAgICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l0aW9uID0gIXRoaXMubGVhZFplcm9EYXRlVGltZSA/IHBvc2l0aW9uICsgMSA6IHBvc2l0aW9uO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cnNvciArPSAxO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX3NoaWZ0U3RlcChtYXNrRXhwcmVzc2lvbiwgY3Vyc29yLCBpbnB1dEFycmF5Lmxlbmd0aCk7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaS0tO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0aGlzLmxlYWRaZXJvRGF0ZVRpbWUpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzdWx0ICs9ICcwJztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7XG4gICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgaWYgKG1hc2tFeHByZXNzaW9uW2N1cnNvcl0gPT09IE1hc2tFeHByZXNzaW9uLk1PTlRIKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBtb250aHNDb3VudCA9IDEyO1xuICAgICAgICAgICAgICAgICAgICAgICAgLy8gbWFzayB3aXRob3V0IGRheVxuICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgd2l0aG91dERheXM6IGJvb2xlYW4gPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cnNvciA9PT0gMCAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIChOdW1iZXIoaW5wdXRTeW1ib2wpID4gMiB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOdW1iZXIoaW5wdXRWYWx1ZVNsaWNlQ3Vyc29yUGx1c1R3bykgPiBtb250aHNDb3VudCB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKGlucHV0VmFsdWVDdXJzb3JQbHVzT25lKSk7XG4gICAgICAgICAgICAgICAgICAgICAgICAvLyBkYXk8MTAgJiYgbW9udGg8MTIgZm9yIGlucHV0XG4gICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzcGVjaWFsQ2hhcnQgPSBtYXNrRXhwcmVzc2lvbi5zbGljZShjdXJzb3IgKyAyLCBjdXJzb3IgKyAzKTtcbiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGRheTFtb250aElucHV0OiBib29sZWFuID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlU2xpY2VNaW51c1RocmVlTWludXNPbmUuaW5jbHVkZXMoc3BlY2lhbENoYXJ0KSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmNsdWRlcyhpbnB1dFZhbHVlQ3Vyc29yTWludXNUd28pICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE51bWJlcihpbnB1dFZhbHVlU2xpY2VNaW51c09uZVBsdXNPbmUpID4gbW9udGhzQ291bnQgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIXRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvcikpIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvcikgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvck1pbnVzVGhyZWUpICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOdW1iZXIoaW5wdXRWYWx1ZVNsaWNlTWludXNUd29DdXJzb3IpID4gbW9udGhzQ291bnQgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICF0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKGlucHV0VmFsdWVDdXJzb3JNaW51c09uZSkpIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvck1pbnVzT25lKSk7XG4gICAgICAgICAgICAgICAgICAgICAgICAvLyAgbW9udGg8MTIgJiYgZGF5PDEwIGZvciBpbnB1dFxuICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgZGF5Mm1vbnRoSW5wdXQ6IGJvb2xlYW4gPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIE51bWJlcihpbnB1dFZhbHVlU2xpY2VNaW51c1RocmVlTWludXNPbmUpIDw9IGRheXNDb3VudCAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICF0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnB1dFZhbHVlU2xpY2VNaW51c1RocmVlTWludXNPbmUgYXMgc3RyaW5nXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgKSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoaW5wdXRWYWx1ZUN1cnNvck1pbnVzT25lKSAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIChOdW1iZXIoaW5wdXRWYWx1ZVNsaWNlQ3Vyc29yUGx1c1R3bykgPiBtb250aHNDb3VudCB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluY2x1ZGVzKGlucHV0VmFsdWVDdXJzb3JQbHVzT25lKSk7XG4gICAgICAgICAgICAgICAgICAgICAgICAvLyBjdXJzb3IgPT09IDUgJiYgd2l0aG91dCBkYXlzXG4gICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBkYXkybW9udGhJbnB1dERvdDogYm9vbGVhbiA9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgKE51bWJlcihpbnB1dFZhbHVlU2xpY2VDdXJzb3JQbHVzVHdvKSA+IG1vbnRoc0NvdW50ICYmIGN1cnNvciA9PT0gNSkgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAodGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmNsdWRlcyhpbnB1dFZhbHVlQ3Vyc29yUGx1c09uZSkgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Vyc29yID09PSA1KTtcbiAgICAgICAgICAgICAgICAgICAgICAgIC8vIC8vIGRheTwxMCAmJiBtb250aDwxMiBmb3IgcGFzdGUgd2hvbGUgZGF0YVxuICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgZGF5MW1vbnRoUGFzdGU6IGJvb2xlYW4gPVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIE51bWJlcihpbnB1dFZhbHVlU2xpY2VNaW51c1RocmVlTWludXNPbmUpID4gZGF5c0NvdW50ICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIXRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVTbGljZU1pbnVzVGhyZWVNaW51c09uZSBhcyBzdHJpbmdcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICApICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIXRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVTbGljZU1pbnVzVHdvQ3Vyc29yIGFzIHN0cmluZ1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICkgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBOdW1iZXIoaW5wdXRWYWx1ZVNsaWNlTWludXNUd29DdXJzb3IpID4gbW9udGhzQ291bnQ7XG4gICAgICAgICAgICAgICAgICAgICAgICAvLyAxMDxkYXk8MzEgJiYgbW9udGg8MTIgZm9yIHBhc3RlIHdob2xlIGRhdGFcbiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGRheTJtb250aFBhc3RlOiBib29sZWFuID1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBOdW1iZXIoaW5wdXRWYWx1ZVNsaWNlTWludXNUaHJlZU1pbnVzT25lKSA8PSBkYXlzQ291bnQgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAhdGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmNsdWRlcyhcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXRWYWx1ZVNsaWNlTWludXNUaHJlZU1pbnVzT25lIGFzIHN0cmluZ1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICkgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAhdGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmNsdWRlcyhpbnB1dFZhbHVlQ3Vyc29yTWludXNPbmUpICYmXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgTnVtYmVyKGlucHV0VmFsdWVTbGljZU1pbnVzT25lUGx1c09uZSkgPiBtb250aHNDb3VudDtcbiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAoTnVtYmVyKGlucHV0U3ltYm9sKSA+IDEgJiYgdGhpcy5sZWFkWmVyb0RhdGVUaW1lKSB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdpdGhvdXREYXlzIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF5MW1vbnRoSW5wdXQgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXkybW9udGhQYXN0ZSB8fFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRheTFtb250aFBhc3RlIHx8XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF5Mm1vbnRoSW5wdXQgfHxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZGF5Mm1vbnRoSW5wdXREb3QgJiYgIXRoaXMubGVhZFplcm9EYXRlVGltZSlcbiAgICAgICAgICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l0aW9uID0gIXRoaXMubGVhZFplcm9EYXRlVGltZSA/IHBvc2l0aW9uICsgMSA6IHBvc2l0aW9uO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cnNvciArPSAxO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMuX3NoaWZ0U3RlcChtYXNrRXhwcmVzc2lvbiwgY3Vyc29yLCBpbnB1dEFycmF5Lmxlbmd0aCk7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaS0tO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0aGlzLmxlYWRaZXJvRGF0ZVRpbWUpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzdWx0ICs9ICcwJztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7XG4gICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgcmVzdWx0ICs9IGlucHV0U3ltYm9sO1xuICAgICAgICAgICAgICAgICAgICBjdXJzb3IrKztcbiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgICAgICAoaW5wdXRTeW1ib2wgPT09IE1hc2tFeHByZXNzaW9uLldISVRFX1NQQUNFICYmXG4gICAgICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbltjdXJzb3JdID09PSBNYXNrRXhwcmVzc2lvbi5XSElURV9TUEFDRSkgfHxcbiAgICAgICAgICAgICAgICAgICAgKGlucHV0U3ltYm9sID09PSBNYXNrRXhwcmVzc2lvbi5TTEFTSCAmJlxuICAgICAgICAgICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bY3Vyc29yXSA9PT0gTWFza0V4cHJlc3Npb24uU0xBU0gpXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIHJlc3VsdCArPSBpbnB1dFN5bWJvbDtcbiAgICAgICAgICAgICAgICAgICAgY3Vyc29yKys7XG4gICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmRleE9mKFxuICAgICAgICAgICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bY3Vyc29yXSA/PyBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkdcbiAgICAgICAgICAgICAgICAgICAgKSAhPT0gLTFcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgcmVzdWx0ICs9IG1hc2tFeHByZXNzaW9uW2N1cnNvcl07XG4gICAgICAgICAgICAgICAgICAgIGN1cnNvcisrO1xuICAgICAgICAgICAgICAgICAgICB0aGlzLl9zaGlmdFN0ZXAobWFza0V4cHJlc3Npb24sIGN1cnNvciwgaW5wdXRBcnJheS5sZW5ndGgpO1xuICAgICAgICAgICAgICAgICAgICBpLS07XG4gICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bY3Vyc29yXSA9PT0gTWFza0V4cHJlc3Npb24uTlVNQkVSX05JTkUgJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5zaG93TWFza1R5cGVkXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX3NoaWZ0U3RlcChtYXNrRXhwcmVzc2lvbiwgY3Vyc29yLCBpbnB1dEFycmF5Lmxlbmd0aCk7XG4gICAgICAgICAgICAgICAgfSBlbHNlIGlmIChcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5wYXR0ZXJuc1ttYXNrRXhwcmVzc2lvbltjdXJzb3JdID8/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR10gJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5wYXR0ZXJuc1ttYXNrRXhwcmVzc2lvbltjdXJzb3JdID8/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR10/Lm9wdGlvbmFsXG4gICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgICEhaW5wdXRBcnJheVtjdXJzb3JdICYmXG4gICAgICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbiAhPT0gJzA5OS4wOTkuMDk5LjA5OScgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uICE9PSAnMDAwLjAwMC4wMDAtMDAnICYmXG4gICAgICAgICAgICAgICAgICAgICAgICBtYXNrRXhwcmVzc2lvbiAhPT0gJzAwLjAwMC4wMDAvMDAwMC0wMCcgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICFtYXNrRXhwcmVzc2lvbi5tYXRjaCgvXjkrXFwuMCskLykgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgICF0aGlzLnBhdHRlcm5zW21hc2tFeHByZXNzaW9uW2N1cnNvcl0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgID8ub3B0aW9uYWxcbiAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXN1bHQgKz0gaW5wdXRBcnJheVtjdXJzb3JdO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIGlmIChcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uLmluY2x1ZGVzKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1hc2tFeHByZXNzaW9uLk5VTUJFUl9OSU5FICsgTWFza0V4cHJlc3Npb24uU1lNQk9MX1NUQVJcbiAgICAgICAgICAgICAgICAgICAgICAgICkgJiZcbiAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tFeHByZXNzaW9uLmluY2x1ZGVzKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1hc2tFeHByZXNzaW9uLk5VTUJFUl9aRVJPICsgTWFza0V4cHJlc3Npb24uU1lNQk9MX1NUQVJcbiAgICAgICAgICAgICAgICAgICAgICAgIClcbiAgICAgICAgICAgICAgICAgICAgKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBjdXJzb3IrKztcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICBjdXJzb3IrKztcbiAgICAgICAgICAgICAgICAgICAgaS0tO1xuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMubWFza0V4cHJlc3Npb25bY3Vyc29yICsgMV0gPT09IE1hc2tFeHByZXNzaW9uLlNZTUJPTF9TVEFSICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX2ZpbmRTcGVjaWFsQ2hhcihcbiAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMubWFza0V4cHJlc3Npb25bY3Vyc29yICsgMl0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICAgICAgICAgICkgJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5fZmluZFNwZWNpYWxDaGFyKGlucHV0U3ltYm9sKSA9PT0gdGhpcy5tYXNrRXhwcmVzc2lvbltjdXJzb3IgKyAyXSAmJlxuICAgICAgICAgICAgICAgICAgICBtdWx0aVxuICAgICAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgICAgICBjdXJzb3IgKz0gMztcbiAgICAgICAgICAgICAgICAgICAgcmVzdWx0ICs9IGlucHV0U3ltYm9sO1xuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoXG4gICAgICAgICAgICAgICAgICAgIHRoaXMubWFza0V4cHJlc3Npb25bY3Vyc29yICsgMV0gPT09IE1hc2tFeHByZXNzaW9uLlNZTUJPTF9RVUVTVElPTiAmJlxuICAgICAgICAgICAgICAgICAgICB0aGlzLl9maW5kU3BlY2lhbENoYXIoXG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLm1hc2tFeHByZXNzaW9uW2N1cnNvciArIDJdID8/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgICAgICAgICApICYmXG4gICAgICAgICAgICAgICAgICAgIHRoaXMuX2ZpbmRTcGVjaWFsQ2hhcihpbnB1dFN5bWJvbCkgPT09IHRoaXMubWFza0V4cHJlc3Npb25bY3Vyc29yICsgMl0gJiZcbiAgICAgICAgICAgICAgICAgICAgbXVsdGlcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgY3Vyc29yICs9IDM7XG4gICAgICAgICAgICAgICAgICAgIHJlc3VsdCArPSBpbnB1dFN5bWJvbDtcbiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKFxuICAgICAgICAgICAgICAgICAgICB0aGlzLnNob3dNYXNrVHlwZWQgJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5zcGVjaWFsQ2hhcmFjdGVycy5pbmRleE9mKGlucHV0U3ltYm9sKSA8IDAgJiZcbiAgICAgICAgICAgICAgICAgICAgaW5wdXRTeW1ib2wgIT09IHRoaXMucGxhY2VIb2xkZXJDaGFyYWN0ZXIgJiZcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5wbGFjZUhvbGRlckNoYXJhY3Rlci5sZW5ndGggPT09IDFcbiAgICAgICAgICAgICAgICApIHtcbiAgICAgICAgICAgICAgICAgICAgc3RlcEJhY2sgPSB0cnVlO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICBpZiAoXG4gICAgICAgICAgICByZXN1bHQubGVuZ3RoICsgMSA9PT0gbWFza0V4cHJlc3Npb24ubGVuZ3RoICYmXG4gICAgICAgICAgICB0aGlzLnNwZWNpYWxDaGFyYWN0ZXJzLmluZGV4T2YoXG4gICAgICAgICAgICAgICAgbWFza0V4cHJlc3Npb25bbWFza0V4cHJlc3Npb24ubGVuZ3RoIC0gMV0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICAgICApICE9PSAtMVxuICAgICAgICApIHtcbiAgICAgICAgICAgIHJlc3VsdCArPSBtYXNrRXhwcmVzc2lvblttYXNrRXhwcmVzc2lvbi5sZW5ndGggLSAxXTtcbiAgICAgICAgfVxuICAgICAgICBsZXQgbmV3UG9zaXRpb246IG51bWJlciA9IHBvc2l0aW9uICsgMTtcblxuICAgICAgICB3aGlsZSAodGhpcy5fc2hpZnQuaGFzKG5ld1Bvc2l0aW9uKSkge1xuICAgICAgICAgICAgc2hpZnQrKztcbiAgICAgICAgICAgIG5ld1Bvc2l0aW9uKys7XG4gICAgICAgIH1cblxuICAgICAgICBsZXQgYWN0dWFsU2hpZnQ6IG51bWJlciA9XG4gICAgICAgICAgICBqdXN0UGFzdGVkICYmICFtYXNrRXhwcmVzc2lvbi5zdGFydHNXaXRoKE1hc2tFeHByZXNzaW9uLlNFUEFSQVRPUilcbiAgICAgICAgICAgICAgICA/IGN1cnNvclxuICAgICAgICAgICAgICAgIDogdGhpcy5fc2hpZnQuaGFzKHBvc2l0aW9uKVxuICAgICAgICAgICAgICAgID8gc2hpZnRcbiAgICAgICAgICAgICAgICA6IDA7XG4gICAgICAgIGlmIChzdGVwQmFjaykge1xuICAgICAgICAgICAgYWN0dWFsU2hpZnQtLTtcbiAgICAgICAgfVxuXG4gICAgICAgIGNiKGFjdHVhbFNoaWZ0LCBiYWNrc3BhY2VTaGlmdCk7XG4gICAgICAgIGlmIChzaGlmdCA8IDApIHtcbiAgICAgICAgICAgIHRoaXMuX3NoaWZ0LmNsZWFyKCk7XG4gICAgICAgIH1cbiAgICAgICAgbGV0IG9ubHlTcGVjaWFsID0gZmFsc2U7XG4gICAgICAgIGlmIChiYWNrc3BhY2VkKSB7XG4gICAgICAgICAgICBvbmx5U3BlY2lhbCA9IGlucHV0QXJyYXkuZXZlcnkoKGNoYXIpID0+IHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuaW5jbHVkZXMoY2hhcikpO1xuICAgICAgICB9XG4gICAgICAgIGxldCByZXMgPSBgJHt0aGlzLnByZWZpeH0ke29ubHlTcGVjaWFsID8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HIDogcmVzdWx0fSR7XG4gICAgICAgICAgICB0aGlzLnNob3dNYXNrVHlwZWQgPyAnJyA6IHRoaXMuc3VmZml4XG4gICAgICAgIH1gO1xuXG4gICAgICAgIGlmIChyZXN1bHQubGVuZ3RoID09PSAwKSB7XG4gICAgICAgICAgICByZXMgPSAhdGhpcy5kcm9wU3BlY2lhbENoYXJhY3RlcnMgPyBgJHt0aGlzLnByZWZpeH0ke3Jlc3VsdH1gIDogYCR7cmVzdWx0fWA7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHJlc3VsdC5pbmNsdWRlcyhNYXNrRXhwcmVzc2lvbi5NSU5VUykgJiYgdGhpcy5wcmVmaXggJiYgdGhpcy5hbGxvd05lZ2F0aXZlTnVtYmVycykge1xuICAgICAgICAgICAgaWYgKGJhY2tzcGFjZWQgJiYgcmVzdWx0ID09PSBNYXNrRXhwcmVzc2lvbi5NSU5VUykge1xuICAgICAgICAgICAgICAgIHJldHVybiAnJztcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHJlcyA9IGAke01hc2tFeHByZXNzaW9uLk1JTlVTfSR7dGhpcy5wcmVmaXh9JHtyZXN1bHRcbiAgICAgICAgICAgICAgICAuc3BsaXQoTWFza0V4cHJlc3Npb24uTUlOVVMpXG4gICAgICAgICAgICAgICAgLmpvaW4oTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HKX0ke3RoaXMuc3VmZml4fWA7XG4gICAgICAgIH1cbiAgICAgICAgcmV0dXJuIHJlcztcbiAgICB9XG5cbiAgICBwdWJsaWMgX2ZpbmREcm9wU3BlY2lhbENoYXIoaW5wdXRTeW1ib2w6IHN0cmluZyk6IHVuZGVmaW5lZCB8IHN0cmluZyB7XG4gICAgICAgIGlmIChBcnJheS5pc0FycmF5KHRoaXMuZHJvcFNwZWNpYWxDaGFyYWN0ZXJzKSkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMuZHJvcFNwZWNpYWxDaGFyYWN0ZXJzLmZpbmQoKHZhbDogc3RyaW5nKSA9PiB2YWwgPT09IGlucHV0U3ltYm9sKTtcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gdGhpcy5fZmluZFNwZWNpYWxDaGFyKGlucHV0U3ltYm9sKTtcbiAgICB9XG5cbiAgICBwdWJsaWMgX2ZpbmRTcGVjaWFsQ2hhcihpbnB1dFN5bWJvbDogc3RyaW5nKTogdW5kZWZpbmVkIHwgc3RyaW5nIHtcbiAgICAgICAgcmV0dXJuIHRoaXMuc3BlY2lhbENoYXJhY3RlcnMuZmluZCgodmFsOiBzdHJpbmcpID0+IHZhbCA9PT0gaW5wdXRTeW1ib2wpO1xuICAgIH1cblxuICAgIHB1YmxpYyBfY2hlY2tTeW1ib2xNYXNrKGlucHV0U3ltYm9sOiBzdHJpbmcsIG1hc2tTeW1ib2w6IHN0cmluZyk6IGJvb2xlYW4ge1xuICAgICAgICB0aGlzLnBhdHRlcm5zID0gdGhpcy5jdXN0b21QYXR0ZXJuID8gdGhpcy5jdXN0b21QYXR0ZXJuIDogdGhpcy5wYXR0ZXJucztcbiAgICAgICAgcmV0dXJuIChcbiAgICAgICAgICAgICh0aGlzLnBhdHRlcm5zW21hc2tTeW1ib2xdPy5wYXR0ZXJuICYmXG4gICAgICAgICAgICAgICAgdGhpcy5wYXR0ZXJuc1ttYXNrU3ltYm9sXT8ucGF0dGVybi50ZXN0KGlucHV0U3ltYm9sKSkgPz9cbiAgICAgICAgICAgIGZhbHNlXG4gICAgICAgICk7XG4gICAgfVxuXG4gICAgcHJpdmF0ZSBfZm9ybWF0V2l0aFNlcGFyYXRvcnMgPSAoXG4gICAgICAgIHN0cjogc3RyaW5nLFxuICAgICAgICB0aG91c2FuZFNlcGFyYXRvckNoYXI6IHN0cmluZyxcbiAgICAgICAgZGVjaW1hbENoYXJzOiBzdHJpbmcgfCBzdHJpbmdbXSxcbiAgICAgICAgcHJlY2lzaW9uOiBudW1iZXJcbiAgICApID0+IHtcbiAgICAgICAgbGV0IHg6IHN0cmluZ1tdID0gW107XG4gICAgICAgIGxldCBkZWNpbWFsQ2hhciA9ICcnO1xuICAgICAgICBpZiAoQXJyYXkuaXNBcnJheShkZWNpbWFsQ2hhcnMpKSB7XG4gICAgICAgICAgICBjb25zdCByZWdFeHAgPSBuZXcgUmVnRXhwKFxuICAgICAgICAgICAgICAgIGRlY2ltYWxDaGFycy5tYXAoKHYpID0+ICgnW1xcXFxeJC58PyorKCknLmluZGV4T2YodikgPj0gMCA/IGBcXFxcJHt2fWAgOiB2KSkuam9pbignfCcpXG4gICAgICAgICAgICApO1xuICAgICAgICAgICAgeCA9IHN0ci5zcGxpdChyZWdFeHApO1xuICAgICAgICAgICAgZGVjaW1hbENoYXIgPSBzdHIubWF0Y2gocmVnRXhwKT8uWzBdID8/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORztcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHggPSBzdHIuc3BsaXQoZGVjaW1hbENoYXJzKTtcbiAgICAgICAgICAgIGRlY2ltYWxDaGFyID0gZGVjaW1hbENoYXJzO1xuICAgICAgICB9XG4gICAgICAgIGNvbnN0IGRlY2ltYWxzOiBzdHJpbmcgPVxuICAgICAgICAgICAgeC5sZW5ndGggPiAxID8gYCR7ZGVjaW1hbENoYXJ9JHt4WzFdfWAgOiBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkc7XG4gICAgICAgIGxldCByZXM6IHN0cmluZyA9IHhbMF0gPz8gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HO1xuICAgICAgICBjb25zdCBzZXBhcmF0b3JMaW1pdDogc3RyaW5nID0gdGhpcy5zZXBhcmF0b3JMaW1pdC5yZXBsYWNlKFxuICAgICAgICAgICAgL1xccy9nLFxuICAgICAgICAgICAgTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HXG4gICAgICAgICk7XG4gICAgICAgIGlmIChzZXBhcmF0b3JMaW1pdCAmJiArc2VwYXJhdG9yTGltaXQpIHtcbiAgICAgICAgICAgIGlmIChyZXNbMF0gPT09IE1hc2tFeHByZXNzaW9uLk1JTlVTKSB7XG4gICAgICAgICAgICAgICAgcmVzID0gYC0ke3Jlcy5zbGljZSgxLCByZXMubGVuZ3RoKS5zbGljZSgwLCBzZXBhcmF0b3JMaW1pdC5sZW5ndGgpfWA7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHJlcyA9IHJlcy5zbGljZSgwLCBzZXBhcmF0b3JMaW1pdC5sZW5ndGgpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIGNvbnN0IHJneCA9IC8oXFxkKykoXFxkezN9KS87XG5cbiAgICAgICAgd2hpbGUgKHRob3VzYW5kU2VwYXJhdG9yQ2hhciAmJiByZ3gudGVzdChyZXMpKSB7XG4gICAgICAgICAgICByZXMgPSByZXMucmVwbGFjZShyZ3gsICckMScgKyB0aG91c2FuZFNlcGFyYXRvckNoYXIgKyAnJDInKTtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmIChwcmVjaXNpb24gPT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgICAgcmV0dXJuIHJlcyArIGRlY2ltYWxzO1xuICAgICAgICB9IGVsc2UgaWYgKHByZWNpc2lvbiA9PT0gMCkge1xuICAgICAgICAgICAgcmV0dXJuIHJlcztcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gcmVzICsgZGVjaW1hbHMuc3Vic3RyaW5nKDAsIHByZWNpc2lvbiArIDEpO1xuICAgIH07XG5cbiAgICBwcml2YXRlIHBlcmNlbnRhZ2UgPSAoc3RyOiBzdHJpbmcpOiBib29sZWFuID0+IHtcbiAgICAgICAgY29uc3Qgc2FuaXRpemVkU3RyID0gc3RyLnJlcGxhY2UoJywnLCAnLicpO1xuICAgICAgICBjb25zdCB2YWx1ZSA9IE51bWJlcihzYW5pdGl6ZWRTdHIpO1xuXG4gICAgICAgIHJldHVybiAhaXNOYU4odmFsdWUpICYmIHZhbHVlID49IDAgJiYgdmFsdWUgPD0gMTAwO1xuICAgIH07XG5cbiAgICBwcml2YXRlIGdldFByZWNpc2lvbiA9IChtYXNrRXhwcmVzc2lvbjogc3RyaW5nKTogbnVtYmVyID0+IHtcbiAgICAgICAgY29uc3QgeDogc3RyaW5nW10gPSBtYXNrRXhwcmVzc2lvbi5zcGxpdChNYXNrRXhwcmVzc2lvbi5ET1QpO1xuICAgICAgICBpZiAoeC5sZW5ndGggPiAxKSB7XG4gICAgICAgICAgICByZXR1cm4gTnVtYmVyKHhbeC5sZW5ndGggLSAxXSk7XG4gICAgICAgIH1cblxuICAgICAgICByZXR1cm4gSW5maW5pdHk7XG4gICAgfTtcblxuICAgIHByaXZhdGUgY2hlY2tBbmRSZW1vdmVTdWZmaXggPSAoaW5wdXRWYWx1ZTogc3RyaW5nKTogc3RyaW5nID0+IHtcbiAgICAgICAgZm9yIChsZXQgaSA9IHRoaXMuc3VmZml4Py5sZW5ndGggLSAxOyBpID49IDA7IGktLSkge1xuICAgICAgICAgICAgY29uc3Qgc3Vic3RyID0gdGhpcy5zdWZmaXguc3Vic3RyaW5nKGksIHRoaXMuc3VmZml4Py5sZW5ndGgpO1xuICAgICAgICAgICAgaWYgKFxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUuaW5jbHVkZXMoc3Vic3RyKSAmJlxuICAgICAgICAgICAgICAgIGkgIT09IHRoaXMuc3VmZml4Py5sZW5ndGggLSAxICYmXG4gICAgICAgICAgICAgICAgKGkgLSAxIDwgMCB8fFxuICAgICAgICAgICAgICAgICAgICAhaW5wdXRWYWx1ZS5pbmNsdWRlcyh0aGlzLnN1ZmZpeC5zdWJzdHJpbmcoaSAtIDEsIHRoaXMuc3VmZml4Py5sZW5ndGgpKSlcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBpbnB1dFZhbHVlLnJlcGxhY2Uoc3Vic3RyLCBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkcpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIHJldHVybiBpbnB1dFZhbHVlO1xuICAgIH07XG5cbiAgICBwcml2YXRlIGNoZWNrSW5wdXRQcmVjaXNpb24gPSAoXG4gICAgICAgIGlucHV0VmFsdWU6IHN0cmluZyxcbiAgICAgICAgcHJlY2lzaW9uOiBudW1iZXIsXG4gICAgICAgIGRlY2ltYWxNYXJrZXI6IElDb25maWdbJ2RlY2ltYWxNYXJrZXInXVxuICAgICk6IHN0cmluZyA9PiB7XG4gICAgICAgIGlmIChwcmVjaXNpb24gPCBJbmZpbml0eSkge1xuICAgICAgICAgICAgLy8gVE9ETyBuZWVkIHRoaW5rIGFib3V0IGRlY2ltYWxNYXJrZXJcbiAgICAgICAgICAgIGlmIChBcnJheS5pc0FycmF5KGRlY2ltYWxNYXJrZXIpKSB7XG4gICAgICAgICAgICAgICAgY29uc3QgbWFya2VyID0gZGVjaW1hbE1hcmtlci5maW5kKChkbSkgPT4gZG0gIT09IHRoaXMudGhvdXNhbmRTZXBhcmF0b3IpO1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGRlY2ltYWxNYXJrZXIgPSBtYXJrZXIgPyBtYXJrZXIgOiBkZWNpbWFsTWFya2VyWzBdO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgY29uc3QgcHJlY2lzaW9uUmVnRXggPSBuZXcgUmVnRXhwKFxuICAgICAgICAgICAgICAgIHRoaXMuX2NoYXJUb1JlZ0V4cEV4cHJlc3Npb24oZGVjaW1hbE1hcmtlcikgKyBgXFxcXGR7JHtwcmVjaXNpb259fS4qJGBcbiAgICAgICAgICAgICk7XG5cbiAgICAgICAgICAgIGNvbnN0IHByZWNpc2lvbk1hdGNoOiBSZWdFeHBNYXRjaEFycmF5IHwgbnVsbCA9IGlucHV0VmFsdWUubWF0Y2gocHJlY2lzaW9uUmVnRXgpO1xuICAgICAgICAgICAgY29uc3QgcHJlY2lzaW9uTWF0Y2hMZW5ndGg6IG51bWJlciA9IChwcmVjaXNpb25NYXRjaCAmJiBwcmVjaXNpb25NYXRjaFswXT8ubGVuZ3RoKSA/PyAwO1xuICAgICAgICAgICAgaWYgKHByZWNpc2lvbk1hdGNoTGVuZ3RoIC0gMSA+IHByZWNpc2lvbikge1xuICAgICAgICAgICAgICAgIGNvbnN0IGRpZmYgPSBwcmVjaXNpb25NYXRjaExlbmd0aCAtIDEgLSBwcmVjaXNpb247XG4gICAgICAgICAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG5vLXBhcmFtLXJlYXNzaWduXG4gICAgICAgICAgICAgICAgaW5wdXRWYWx1ZSA9IGlucHV0VmFsdWUuc3Vic3RyaW5nKDAsIGlucHV0VmFsdWUubGVuZ3RoIC0gZGlmZik7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBpZiAoXG4gICAgICAgICAgICAgICAgcHJlY2lzaW9uID09PSAwICYmXG4gICAgICAgICAgICAgICAgdGhpcy5fY29tcGFyZU9ySW5jbHVkZXMoXG4gICAgICAgICAgICAgICAgICAgIGlucHV0VmFsdWVbaW5wdXRWYWx1ZS5sZW5ndGggLSAxXSxcbiAgICAgICAgICAgICAgICAgICAgZGVjaW1hbE1hcmtlcixcbiAgICAgICAgICAgICAgICAgICAgdGhpcy50aG91c2FuZFNlcGFyYXRvclxuICAgICAgICAgICAgICAgIClcbiAgICAgICAgICAgICkge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBuby1wYXJhbS1yZWFzc2lnblxuICAgICAgICAgICAgICAgIGlucHV0VmFsdWUgPSBpbnB1dFZhbHVlLnN1YnN0cmluZygwLCBpbnB1dFZhbHVlLmxlbmd0aCAtIDEpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIHJldHVybiBpbnB1dFZhbHVlO1xuICAgIH07XG5cbiAgICBwcml2YXRlIF9zdHJpcFRvRGVjaW1hbChzdHI6IHN0cmluZyk6IHN0cmluZyB7XG4gICAgICAgIHJldHVybiBzdHJcbiAgICAgICAgICAgIC5zcGxpdChNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkcpXG4gICAgICAgICAgICAuZmlsdGVyKChpOiBzdHJpbmcsIGlkeDogbnVtYmVyKSA9PiB7XG4gICAgICAgICAgICAgICAgY29uc3QgaXNEZWNpbWFsTWFya2VyID1cbiAgICAgICAgICAgICAgICAgICAgdHlwZW9mIHRoaXMuZGVjaW1hbE1hcmtlciA9PT0gJ3N0cmluZydcbiAgICAgICAgICAgICAgICAgICAgICAgID8gaSA9PT0gdGhpcy5kZWNpbWFsTWFya2VyXG4gICAgICAgICAgICAgICAgICAgICAgICA6IC8vIFRPRE8gKGluZXBpcGVua28pIHVzZSB1dGlsaXR5IHR5cGVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5kZWNpbWFsTWFya2VyLmluY2x1ZGVzKFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSBhcyBNYXNrRXhwcmVzc2lvbi5DT01NQSB8IE1hc2tFeHByZXNzaW9uLkRPVFxuICAgICAgICAgICAgICAgICAgICAgICAgICApO1xuICAgICAgICAgICAgICAgIHJldHVybiAoXG4gICAgICAgICAgICAgICAgICAgIGkubWF0Y2goJ14tP1xcXFxkJykgfHxcbiAgICAgICAgICAgICAgICAgICAgaSA9PT0gdGhpcy50aG91c2FuZFNlcGFyYXRvciB8fFxuICAgICAgICAgICAgICAgICAgICBpc0RlY2ltYWxNYXJrZXIgfHxcbiAgICAgICAgICAgICAgICAgICAgKGkgPT09IE1hc2tFeHByZXNzaW9uLk1JTlVTICYmIGlkeCA9PT0gMCAmJiB0aGlzLmFsbG93TmVnYXRpdmVOdW1iZXJzKVxuICAgICAgICAgICAgICAgICk7XG4gICAgICAgICAgICB9KVxuICAgICAgICAgICAgLmpvaW4oTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HKTtcbiAgICB9XG5cbiAgICBwcml2YXRlIF9jaGFyVG9SZWdFeHBFeHByZXNzaW9uKGNoYXI6IHN0cmluZyk6IHN0cmluZyB7XG4gICAgICAgIC8vIGlmIChBcnJheS5pc0FycmF5KGNoYXIpKSB7XG4gICAgICAgIC8vIFx0cmV0dXJuIGNoYXIubWFwKCh2KSA9PiAoJ1tcXFxcXiQufD8qKygpJy5pbmRleE9mKHYpID49IDAgPyBgXFxcXCR7dn1gIDogdikpLmpvaW4oJ3wnKTtcbiAgICAgICAgLy8gfVxuICAgICAgICBpZiAoY2hhcikge1xuICAgICAgICAgICAgY29uc3QgY2hhcnNUb0VzY2FwZSA9ICdbXFxcXF4kLnw/KisoKSc7XG4gICAgICAgICAgICByZXR1cm4gY2hhciA9PT0gJyAnID8gJ1xcXFxzJyA6IGNoYXJzVG9Fc2NhcGUuaW5kZXhPZihjaGFyKSA+PSAwID8gYFxcXFwke2NoYXJ9YCA6IGNoYXI7XG4gICAgICAgIH1cbiAgICAgICAgcmV0dXJuIGNoYXI7XG4gICAgfVxuXG4gICAgcHJpdmF0ZSBfc2hpZnRTdGVwKG1hc2tFeHByZXNzaW9uOiBzdHJpbmcsIGN1cnNvcjogbnVtYmVyLCBpbnB1dExlbmd0aDogbnVtYmVyKSB7XG4gICAgICAgIGNvbnN0IHNoaWZ0U3RlcDogbnVtYmVyID0gL1sqP10vZy50ZXN0KG1hc2tFeHByZXNzaW9uLnNsaWNlKDAsIGN1cnNvcikpXG4gICAgICAgICAgICA/IGlucHV0TGVuZ3RoXG4gICAgICAgICAgICA6IGN1cnNvcjtcbiAgICAgICAgdGhpcy5fc2hpZnQuYWRkKHNoaWZ0U3RlcCArIHRoaXMucHJlZml4Lmxlbmd0aCB8fCAwKTtcbiAgICB9XG5cbiAgICBwcm90ZWN0ZWQgX2NvbXBhcmVPckluY2x1ZGVzPFQ+KHZhbHVlOiBULCBjb21wYXJlZFZhbHVlOiBUIHwgVFtdLCBleGNsdWRlZFZhbHVlOiBUKTogYm9vbGVhbiB7XG4gICAgICAgIHJldHVybiBBcnJheS5pc0FycmF5KGNvbXBhcmVkVmFsdWUpXG4gICAgICAgICAgICA/IGNvbXBhcmVkVmFsdWUuZmlsdGVyKCh2KSA9PiB2ICE9PSBleGNsdWRlZFZhbHVlKS5pbmNsdWRlcyh2YWx1ZSlcbiAgICAgICAgICAgIDogdmFsdWUgPT09IGNvbXBhcmVkVmFsdWU7XG4gICAgfVxuXG4gICAgcHJpdmF0ZSBfdmFsaWRJUCh2YWx1ZXNJUDogc3RyaW5nW10pOiBib29sZWFuIHtcbiAgICAgICAgcmV0dXJuICEoXG4gICAgICAgICAgICB2YWx1ZXNJUC5sZW5ndGggPT09IDQgJiZcbiAgICAgICAgICAgICF2YWx1ZXNJUC5zb21lKCh2YWx1ZTogc3RyaW5nLCBpbmRleDogbnVtYmVyKSA9PiB7XG4gICAgICAgICAgICAgICAgaWYgKHZhbHVlc0lQLmxlbmd0aCAhPT0gaW5kZXggKyAxKSB7XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiB2YWx1ZSA9PT0gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HIHx8IE51bWJlcih2YWx1ZSkgPiAyNTU7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHJldHVybiB2YWx1ZSA9PT0gTWFza0V4cHJlc3Npb24uRU1QVFlfU1RSSU5HIHx8IE51bWJlcih2YWx1ZS5zdWJzdHJpbmcoMCwgMykpID4gMjU1O1xuICAgICAgICAgICAgfSlcbiAgICAgICAgKTtcbiAgICB9XG5cbiAgICBwcml2YXRlIF9zcGxpdFBlcmNlbnRaZXJvKHZhbHVlOiBzdHJpbmcpOiBzdHJpbmcge1xuICAgICAgICBjb25zdCBkZWNpbWFsSW5kZXggPVxuICAgICAgICAgICAgdHlwZW9mIHRoaXMuZGVjaW1hbE1hcmtlciA9PT0gJ3N0cmluZydcbiAgICAgICAgICAgICAgICA/IHZhbHVlLmluZGV4T2YodGhpcy5kZWNpbWFsTWFya2VyKVxuICAgICAgICAgICAgICAgIDogdmFsdWUuaW5kZXhPZihNYXNrRXhwcmVzc2lvbi5ET1QpO1xuICAgICAgICBpZiAoZGVjaW1hbEluZGV4ID09PSAtMSkge1xuICAgICAgICAgICAgY29uc3QgcGFyc2VkVmFsdWUgPSBwYXJzZUludCh2YWx1ZSwgMTApO1xuICAgICAgICAgICAgcmV0dXJuIGlzTmFOKHBhcnNlZFZhbHVlKSA/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklORyA6IHBhcnNlZFZhbHVlLnRvU3RyaW5nKCk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICBjb25zdCBpbnRlZ2VyUGFydCA9IHBhcnNlSW50KHZhbHVlLnN1YnN0cmluZygwLCBkZWNpbWFsSW5kZXgpLCAxMCk7XG4gICAgICAgICAgICBjb25zdCBkZWNpbWFsUGFydCA9IHZhbHVlLnN1YnN0cmluZyhkZWNpbWFsSW5kZXggKyAxKTtcbiAgICAgICAgICAgIGNvbnN0IGludGVnZXJTdHJpbmcgPSBpc05hTihpbnRlZ2VyUGFydCkgPyAnJyA6IGludGVnZXJQYXJ0LnRvU3RyaW5nKCk7XG4gICAgICAgICAgICBjb25zdCBkZWNpbWFsID1cbiAgICAgICAgICAgICAgICB0eXBlb2YgdGhpcy5kZWNpbWFsTWFya2VyID09PSAnc3RyaW5nJyA/IHRoaXMuZGVjaW1hbE1hcmtlciA6IE1hc2tFeHByZXNzaW9uLkRPVDtcbiAgICAgICAgICAgIHJldHVybiBpbnRlZ2VyU3RyaW5nID09PSBNYXNrRXhwcmVzc2lvbi5FTVBUWV9TVFJJTkdcbiAgICAgICAgICAgICAgICA/IE1hc2tFeHByZXNzaW9uLkVNUFRZX1NUUklOR1xuICAgICAgICAgICAgICAgIDogaW50ZWdlclN0cmluZyArIGRlY2ltYWwgKyBkZWNpbWFsUGFydDtcbiAgICAgICAgfVxuICAgIH1cbn1cbiJdfQ==