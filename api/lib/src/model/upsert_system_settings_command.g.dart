// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_system_settings_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpsertSystemSettingsCommand extends UpsertSystemSettingsCommand {
  @override
  final bool? enableLocalSignUp;
  @override
  final String? currencyDisplay;
  @override
  final CurrencySeparator currencyThousandthsSeparator;
  @override
  final CurrencySeparator currencyDecimalSeparator;
  @override
  final CurrencySymbolPosition currencySymbolPosition;
  @override
  final bool currencyHideDecimalPlaces;
  @override
  final bool? debugOcr;
  @override
  final int? numWorkers;
  @override
  final int? emailPollingInterval;
  @override
  final int? receiptProcessingSettingsId;
  @override
  final int? fallbackReceiptProcessingSettingsId;

  factory _$UpsertSystemSettingsCommand(
          [void Function(UpsertSystemSettingsCommandBuilder)? updates]) =>
      (new UpsertSystemSettingsCommandBuilder()..update(updates))._build();

  _$UpsertSystemSettingsCommand._(
      {this.enableLocalSignUp,
      this.currencyDisplay,
      required this.currencyThousandthsSeparator,
      required this.currencyDecimalSeparator,
      required this.currencySymbolPosition,
      required this.currencyHideDecimalPlaces,
      this.debugOcr,
      this.numWorkers,
      this.emailPollingInterval,
      this.receiptProcessingSettingsId,
      this.fallbackReceiptProcessingSettingsId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(currencyThousandthsSeparator,
        r'UpsertSystemSettingsCommand', 'currencyThousandthsSeparator');
    BuiltValueNullFieldError.checkNotNull(currencyDecimalSeparator,
        r'UpsertSystemSettingsCommand', 'currencyDecimalSeparator');
    BuiltValueNullFieldError.checkNotNull(currencySymbolPosition,
        r'UpsertSystemSettingsCommand', 'currencySymbolPosition');
    BuiltValueNullFieldError.checkNotNull(currencyHideDecimalPlaces,
        r'UpsertSystemSettingsCommand', 'currencyHideDecimalPlaces');
  }

  @override
  UpsertSystemSettingsCommand rebuild(
          void Function(UpsertSystemSettingsCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpsertSystemSettingsCommandBuilder toBuilder() =>
      new UpsertSystemSettingsCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpsertSystemSettingsCommand &&
        enableLocalSignUp == other.enableLocalSignUp &&
        currencyDisplay == other.currencyDisplay &&
        currencyThousandthsSeparator == other.currencyThousandthsSeparator &&
        currencyDecimalSeparator == other.currencyDecimalSeparator &&
        currencySymbolPosition == other.currencySymbolPosition &&
        currencyHideDecimalPlaces == other.currencyHideDecimalPlaces &&
        debugOcr == other.debugOcr &&
        numWorkers == other.numWorkers &&
        emailPollingInterval == other.emailPollingInterval &&
        receiptProcessingSettingsId == other.receiptProcessingSettingsId &&
        fallbackReceiptProcessingSettingsId ==
            other.fallbackReceiptProcessingSettingsId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enableLocalSignUp.hashCode);
    _$hash = $jc(_$hash, currencyDisplay.hashCode);
    _$hash = $jc(_$hash, currencyThousandthsSeparator.hashCode);
    _$hash = $jc(_$hash, currencyDecimalSeparator.hashCode);
    _$hash = $jc(_$hash, currencySymbolPosition.hashCode);
    _$hash = $jc(_$hash, currencyHideDecimalPlaces.hashCode);
    _$hash = $jc(_$hash, debugOcr.hashCode);
    _$hash = $jc(_$hash, numWorkers.hashCode);
    _$hash = $jc(_$hash, emailPollingInterval.hashCode);
    _$hash = $jc(_$hash, receiptProcessingSettingsId.hashCode);
    _$hash = $jc(_$hash, fallbackReceiptProcessingSettingsId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpsertSystemSettingsCommand')
          ..add('enableLocalSignUp', enableLocalSignUp)
          ..add('currencyDisplay', currencyDisplay)
          ..add('currencyThousandthsSeparator', currencyThousandthsSeparator)
          ..add('currencyDecimalSeparator', currencyDecimalSeparator)
          ..add('currencySymbolPosition', currencySymbolPosition)
          ..add('currencyHideDecimalPlaces', currencyHideDecimalPlaces)
          ..add('debugOcr', debugOcr)
          ..add('numWorkers', numWorkers)
          ..add('emailPollingInterval', emailPollingInterval)
          ..add('receiptProcessingSettingsId', receiptProcessingSettingsId)
          ..add('fallbackReceiptProcessingSettingsId',
              fallbackReceiptProcessingSettingsId))
        .toString();
  }
}

class UpsertSystemSettingsCommandBuilder
    implements
        Builder<UpsertSystemSettingsCommand,
            UpsertSystemSettingsCommandBuilder> {
  _$UpsertSystemSettingsCommand? _$v;

  bool? _enableLocalSignUp;
  bool? get enableLocalSignUp => _$this._enableLocalSignUp;
  set enableLocalSignUp(bool? enableLocalSignUp) =>
      _$this._enableLocalSignUp = enableLocalSignUp;

  String? _currencyDisplay;
  String? get currencyDisplay => _$this._currencyDisplay;
  set currencyDisplay(String? currencyDisplay) =>
      _$this._currencyDisplay = currencyDisplay;

  CurrencySeparator? _currencyThousandthsSeparator;
  CurrencySeparator? get currencyThousandthsSeparator =>
      _$this._currencyThousandthsSeparator;
  set currencyThousandthsSeparator(
          CurrencySeparator? currencyThousandthsSeparator) =>
      _$this._currencyThousandthsSeparator = currencyThousandthsSeparator;

  CurrencySeparator? _currencyDecimalSeparator;
  CurrencySeparator? get currencyDecimalSeparator =>
      _$this._currencyDecimalSeparator;
  set currencyDecimalSeparator(CurrencySeparator? currencyDecimalSeparator) =>
      _$this._currencyDecimalSeparator = currencyDecimalSeparator;

  CurrencySymbolPosition? _currencySymbolPosition;
  CurrencySymbolPosition? get currencySymbolPosition =>
      _$this._currencySymbolPosition;
  set currencySymbolPosition(CurrencySymbolPosition? currencySymbolPosition) =>
      _$this._currencySymbolPosition = currencySymbolPosition;

  bool? _currencyHideDecimalPlaces;
  bool? get currencyHideDecimalPlaces => _$this._currencyHideDecimalPlaces;
  set currencyHideDecimalPlaces(bool? currencyHideDecimalPlaces) =>
      _$this._currencyHideDecimalPlaces = currencyHideDecimalPlaces;

  bool? _debugOcr;
  bool? get debugOcr => _$this._debugOcr;
  set debugOcr(bool? debugOcr) => _$this._debugOcr = debugOcr;

  int? _numWorkers;
  int? get numWorkers => _$this._numWorkers;
  set numWorkers(int? numWorkers) => _$this._numWorkers = numWorkers;

  int? _emailPollingInterval;
  int? get emailPollingInterval => _$this._emailPollingInterval;
  set emailPollingInterval(int? emailPollingInterval) =>
      _$this._emailPollingInterval = emailPollingInterval;

  int? _receiptProcessingSettingsId;
  int? get receiptProcessingSettingsId => _$this._receiptProcessingSettingsId;
  set receiptProcessingSettingsId(int? receiptProcessingSettingsId) =>
      _$this._receiptProcessingSettingsId = receiptProcessingSettingsId;

  int? _fallbackReceiptProcessingSettingsId;
  int? get fallbackReceiptProcessingSettingsId =>
      _$this._fallbackReceiptProcessingSettingsId;
  set fallbackReceiptProcessingSettingsId(
          int? fallbackReceiptProcessingSettingsId) =>
      _$this._fallbackReceiptProcessingSettingsId =
          fallbackReceiptProcessingSettingsId;

  UpsertSystemSettingsCommandBuilder() {
    UpsertSystemSettingsCommand._defaults(this);
  }

  UpsertSystemSettingsCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enableLocalSignUp = $v.enableLocalSignUp;
      _currencyDisplay = $v.currencyDisplay;
      _currencyThousandthsSeparator = $v.currencyThousandthsSeparator;
      _currencyDecimalSeparator = $v.currencyDecimalSeparator;
      _currencySymbolPosition = $v.currencySymbolPosition;
      _currencyHideDecimalPlaces = $v.currencyHideDecimalPlaces;
      _debugOcr = $v.debugOcr;
      _numWorkers = $v.numWorkers;
      _emailPollingInterval = $v.emailPollingInterval;
      _receiptProcessingSettingsId = $v.receiptProcessingSettingsId;
      _fallbackReceiptProcessingSettingsId =
          $v.fallbackReceiptProcessingSettingsId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpsertSystemSettingsCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpsertSystemSettingsCommand;
  }

  @override
  void update(void Function(UpsertSystemSettingsCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpsertSystemSettingsCommand build() => _build();

  _$UpsertSystemSettingsCommand _build() {
    final _$result = _$v ??
        new _$UpsertSystemSettingsCommand._(
            enableLocalSignUp: enableLocalSignUp,
            currencyDisplay: currencyDisplay,
            currencyThousandthsSeparator: BuiltValueNullFieldError.checkNotNull(
                currencyThousandthsSeparator,
                r'UpsertSystemSettingsCommand',
                'currencyThousandthsSeparator'),
            currencyDecimalSeparator: BuiltValueNullFieldError.checkNotNull(
                currencyDecimalSeparator,
                r'UpsertSystemSettingsCommand',
                'currencyDecimalSeparator'),
            currencySymbolPosition: BuiltValueNullFieldError.checkNotNull(
                currencySymbolPosition,
                r'UpsertSystemSettingsCommand',
                'currencySymbolPosition'),
            currencyHideDecimalPlaces: BuiltValueNullFieldError.checkNotNull(
                currencyHideDecimalPlaces,
                r'UpsertSystemSettingsCommand',
                'currencyHideDecimalPlaces'),
            debugOcr: debugOcr,
            numWorkers: numWorkers,
            emailPollingInterval: emailPollingInterval,
            receiptProcessingSettingsId: receiptProcessingSettingsId,
            fallbackReceiptProcessingSettingsId:
                fallbackReceiptProcessingSettingsId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
