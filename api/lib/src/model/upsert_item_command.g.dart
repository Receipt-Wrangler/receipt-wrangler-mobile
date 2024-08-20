// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_item_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpsertItemCommand extends UpsertItemCommand {
  @override
  final String amount;
  @override
  final int chargedToUserId;
  @override
  final String name;
  @override
  final int receiptId;
  @override
  final ItemStatus status;

  factory _$UpsertItemCommand(
          [void Function(UpsertItemCommandBuilder)? updates]) =>
      (new UpsertItemCommandBuilder()..update(updates))._build();

  _$UpsertItemCommand._(
      {required this.amount,
      required this.chargedToUserId,
      required this.name,
      required this.receiptId,
      required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, r'UpsertItemCommand', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        chargedToUserId, r'UpsertItemCommand', 'chargedToUserId');
    BuiltValueNullFieldError.checkNotNull(name, r'UpsertItemCommand', 'name');
    BuiltValueNullFieldError.checkNotNull(
        receiptId, r'UpsertItemCommand', 'receiptId');
    BuiltValueNullFieldError.checkNotNull(
        status, r'UpsertItemCommand', 'status');
  }

  @override
  UpsertItemCommand rebuild(void Function(UpsertItemCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpsertItemCommandBuilder toBuilder() =>
      new UpsertItemCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpsertItemCommand &&
        amount == other.amount &&
        chargedToUserId == other.chargedToUserId &&
        name == other.name &&
        receiptId == other.receiptId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, chargedToUserId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, receiptId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpsertItemCommand')
          ..add('amount', amount)
          ..add('chargedToUserId', chargedToUserId)
          ..add('name', name)
          ..add('receiptId', receiptId)
          ..add('status', status))
        .toString();
  }
}

class UpsertItemCommandBuilder
    implements Builder<UpsertItemCommand, UpsertItemCommandBuilder> {
  _$UpsertItemCommand? _$v;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  int? _chargedToUserId;
  int? get chargedToUserId => _$this._chargedToUserId;
  set chargedToUserId(int? chargedToUserId) =>
      _$this._chargedToUserId = chargedToUserId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _receiptId;
  int? get receiptId => _$this._receiptId;
  set receiptId(int? receiptId) => _$this._receiptId = receiptId;

  ItemStatus? _status;
  ItemStatus? get status => _$this._status;
  set status(ItemStatus? status) => _$this._status = status;

  UpsertItemCommandBuilder() {
    UpsertItemCommand._defaults(this);
  }

  UpsertItemCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _chargedToUserId = $v.chargedToUserId;
      _name = $v.name;
      _receiptId = $v.receiptId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpsertItemCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpsertItemCommand;
  }

  @override
  void update(void Function(UpsertItemCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpsertItemCommand build() => _build();

  _$UpsertItemCommand _build() {
    final _$result = _$v ??
        new _$UpsertItemCommand._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'UpsertItemCommand', 'amount'),
            chargedToUserId: BuiltValueNullFieldError.checkNotNull(
                chargedToUserId, r'UpsertItemCommand', 'chargedToUserId'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'UpsertItemCommand', 'name'),
            receiptId: BuiltValueNullFieldError.checkNotNull(
                receiptId, r'UpsertItemCommand', 'receiptId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'UpsertItemCommand', 'status'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
