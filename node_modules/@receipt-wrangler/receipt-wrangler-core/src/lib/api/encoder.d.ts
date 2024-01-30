import { HttpUrlEncodingCodec } from '@angular/common/http';
/**
 * CustomHttpUrlEncodingCodec
 * Fix plus sign (+) not encoding, so sent as blank space
 * See: https://github.com/angular/angular/issues/11058#issuecomment-247367318
 */
export declare class CustomHttpUrlEncodingCodec extends HttpUrlEncodingCodec {
    encodeKey(k: string): string;
    encodeValue(v: string): string;
}
