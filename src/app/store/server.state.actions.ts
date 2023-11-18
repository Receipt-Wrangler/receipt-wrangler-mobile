export class SetServerUrl {
  static readonly type = '[Server] Set Server URL';
  constructor(public url?: string) {}
}
