// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SystemSettings extends SystemSettings {
  @override
  final int? receiptProcessingSettingsId;
  @override
  final String? currencyDisplay;
  @override
  final int? emailPollingInterval;
  @override
  final int? numWorkers;
  @override
  final bool? enableLocalSignUp;
  @override
  final bool? debugOcr;
  @override
  final int? fallbackReceiptProcessingSettingsId;
  @override
  final int id;
  @override
  final String createdAt;
  @override
  final int? createdBy;
  @override
  final String? createdByString;
  @override
  final String? updatedAt;

  factory _$SystemSettings([void Function(SystemSettingsBuilder)? updates]) =>
      (new SystemSettingsBuilder()..update(updates))._build();

  _$SystemSettings._(
      {this.receiptProcessingSettingsId,
      this.currencyDisplay,
      this.emailPollingInterval,
      this.numWorkers,
      this.enableLocalSignUp,
      this.debugOcr,
      this.fallbackReceiptProcessingSettingsId,
      required this.id,
      required this.createdAt,
      this.createdBy,
      this.createdByString,
      this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SystemSettings', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'SystemSettings', 'createdAt');
  }

  @override
  SystemSettings rebuild(void Function(SystemSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemSettingsBuilder toBuilder() =>
      new SystemSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemSettings &&
        receiptProcessingSettingsId == other.receiptProcessingSettingsId &&
        currencyDisplay == other.currencyDisplay &&
        emailPollingInterval == other.emailPollingInterval &&
        numWorkers == other.numWorkers &&
        enableLocalSignUp == other.enableLocalSignUp &&
        debugOcr == other.debugOcr &&
        fallbackReceiptProcessingSettingsId ==
            other.fallbackReceiptProcessingSettingsId &&
        id == other.id &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        createdByString == other.createdByString &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, receiptProcessingSettingsId.hashCode);
    _$hash = $jc(_$hash, currencyDisplay.hashCode);
    _$hash = $jc(_$hash, emailPollingInterval.hashCode);
    _$hash = $jc(_$hash, numWorkers.hashCode);
    _$hash = $jc(_$hash, enableLocalSignUp.hashCode);
    _$hash = $jc(_$hash, debugOcr.hashCode);
    _$hash = $jc(_$hash, fallbackReceiptProcessingSettingsId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, createdByString.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemSettings')
          ..add('receiptProcessingSettingsId', receiptProcessingSettingsId)
          ..add('currencyDisplay', currencyDisplay)
          ..add('emailPollingInterval', emailPollingInterval)
          ..add('numWorkers', numWorkers)
          ..add('enableLocalSignUp', enableLocalSignUp)
          ..add('debugOcr', debugOcr)
          ..add('fallbackReceiptProcessingSettingsId',
              fallbackReceiptProcessingSettingsId)
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('createdByString', createdByString)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SystemSettingsBuilder
    implements
        Builder<SystemSettings, SystemSettingsBuilder>,
        BaseModelBuilder {
  _$SystemSettings? _$v;

  int? _receiptProcessingSettingsId;
  int? get receiptProcessingSettingsId => _$this._receiptProcessingSettingsId;
  set receiptProcessingSettingsId(covariant int? receiptProcessingSettingsId) =>
      _$this._receiptProcessingSettingsId = receiptProcessingSettingsId;

  String? _currencyDisplay;
  String? get currencyDisplay => _$this._currencyDisplay;
  set currencyDisplay(covariant String? currencyDisplay) =>
      _$this._currencyDisplay = currencyDisplay;

  int? _emailPollingInterval;
  int? get emailPollingInterval => _$this._emailPollingInterval;
  set emailPollingInterval(covariant int? emailPollingInterval) =>
      _$this._emailPollingInterval = emailPollingInterval;

  int? _numWorkers;
  int? get numWorkers => _$this._numWorkers;
  set numWorkers(covariant int? numWorkers) => _$this._numWorkers = numWorkers;

  bool? _enableLocalSignUp;
  bool? get enableLocalSignUp => _$this._enableLocalSignUp;
  set enableLocalSignUp(covariant bool? enableLocalSignUp) =>
      _$this._enableLocalSignUp = enableLocalSignUp;

  bool? _debugOcr;
  bool? get debugOcr => _$this._debugOcr;
  set debugOcr(covariant bool? debugOcr) => _$this._debugOcr = debugOcr;

  int? _fallbackReceiptProcessingSettingsId;
  int? get fallbackReceiptProcessingSettingsId =>
      _$this._fallbackReceiptProcessingSettingsId;
  set fallbackReceiptProcessingSettingsId(
          covariant int? fallbackReceiptProcessingSettingsId) =>
      _$this._fallbackReceiptProcessingSettingsId =
          fallbackReceiptProcessingSettingsId;

  int? _id;
  int? get id => _$this._id;
  set id(covariant int? id) => _$this._id = id;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(covariant String? createdAt) => _$this._createdAt = createdAt;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(covariant int? createdBy) => _$this._createdBy = createdBy;

  String? _createdByString;
  String? get createdByString => _$this._createdByString;
  set createdByString(covariant String? createdByString) =>
      _$this._createdByString = createdByString;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(covariant String? updatedAt) => _$this._updatedAt = updatedAt;

  SystemSettingsBuilder() {
    SystemSettings._defaults(this);
  }

  SystemSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiptProcessingSettingsId = $v.receiptProcessingSettingsId;
      _currencyDisplay = $v.currencyDisplay;
      _emailPollingInterval = $v.emailPollingInterval;
      _numWorkers = $v.numWorkers;
      _enableLocalSignUp = $v.enableLocalSignUp;
      _debugOcr = $v.debugOcr;
      _fallbackReceiptProcessingSettingsId =
          $v.fallbackReceiptProcessingSettingsId;
      _id = $v.id;
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _createdByString = $v.createdByString;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SystemSettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SystemSettings;
  }

  @override
  void update(void Function(SystemSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemSettings build() => _build();

  _$SystemSettings _build() {
    final _$result = _$v ??
        new _$SystemSettings._(
            receiptProcessingSettingsId: receiptProcessingSettingsId,
            currencyDisplay: currencyDisplay,
            emailPollingInterval: emailPollingInterval,
            numWorkers: numWorkers,
            enableLocalSignUp: enableLocalSignUp,
            debugOcr: debugOcr,
            fallbackReceiptProcessingSettingsId:
                fallbackReceiptProcessingSettingsId,
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'SystemSettings', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SystemSettings', 'createdAt'),
            createdBy: createdBy,
            createdByString: createdByString,
            updatedAt: updatedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint