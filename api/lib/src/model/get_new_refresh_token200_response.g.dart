// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_new_refresh_token200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetNewRefreshToken200Response extends GetNewRefreshToken200Response {
  @override
  final OneOf oneOf;

  factory _$GetNewRefreshToken200Response(
          [void Function(GetNewRefreshToken200ResponseBuilder)? updates]) =>
      (new GetNewRefreshToken200ResponseBuilder()..update(updates))._build();

  _$GetNewRefreshToken200Response._({required this.oneOf}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        oneOf, r'GetNewRefreshToken200Response', 'oneOf');
  }

  @override
  GetNewRefreshToken200Response rebuild(
          void Function(GetNewRefreshToken200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetNewRefreshToken200ResponseBuilder toBuilder() =>
      new GetNewRefreshToken200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetNewRefreshToken200Response && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetNewRefreshToken200Response')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class GetNewRefreshToken200ResponseBuilder
    implements
        Builder<GetNewRefreshToken200Response,
            GetNewRefreshToken200ResponseBuilder> {
  _$GetNewRefreshToken200Response? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  GetNewRefreshToken200ResponseBuilder() {
    GetNewRefreshToken200Response._defaults(this);
  }

  GetNewRefreshToken200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetNewRefreshToken200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetNewRefreshToken200Response;
  }

  @override
  void update(void Function(GetNewRefreshToken200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetNewRefreshToken200Response build() => _build();

  _$GetNewRefreshToken200Response _build() {
    final _$result = _$v ??
        new _$GetNewRefreshToken200Response._(
            oneOf: BuiltValueNullFieldError.checkNotNull(
                oneOf, r'GetNewRefreshToken200Response', 'oneOf'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
