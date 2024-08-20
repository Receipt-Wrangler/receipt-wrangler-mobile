// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_paged_request_filter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReceiptPagedRequestFilter extends ReceiptPagedRequestFilter {
  @override
  final PagedRequestField? date;
  @override
  final PagedRequestField? amount;
  @override
  final PagedRequestField? name;
  @override
  final PagedRequestField? paidBy;
  @override
  final PagedRequestField? categories;
  @override
  final PagedRequestField? tags;
  @override
  final PagedRequestField? status;
  @override
  final PagedRequestField? resolvedDate;
  @override
  final PagedRequestField? createdAt;

  factory _$ReceiptPagedRequestFilter(
          [void Function(ReceiptPagedRequestFilterBuilder)? updates]) =>
      (new ReceiptPagedRequestFilterBuilder()..update(updates))._build();

  _$ReceiptPagedRequestFilter._(
      {this.date,
      this.amount,
      this.name,
      this.paidBy,
      this.categories,
      this.tags,
      this.status,
      this.resolvedDate,
      this.createdAt})
      : super._();

  @override
  ReceiptPagedRequestFilter rebuild(
          void Function(ReceiptPagedRequestFilterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReceiptPagedRequestFilterBuilder toBuilder() =>
      new ReceiptPagedRequestFilterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReceiptPagedRequestFilter &&
        date == other.date &&
        amount == other.amount &&
        name == other.name &&
        paidBy == other.paidBy &&
        categories == other.categories &&
        tags == other.tags &&
        status == other.status &&
        resolvedDate == other.resolvedDate &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, paidBy.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, resolvedDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReceiptPagedRequestFilter')
          ..add('date', date)
          ..add('amount', amount)
          ..add('name', name)
          ..add('paidBy', paidBy)
          ..add('categories', categories)
          ..add('tags', tags)
          ..add('status', status)
          ..add('resolvedDate', resolvedDate)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ReceiptPagedRequestFilterBuilder
    implements
        Builder<ReceiptPagedRequestFilter, ReceiptPagedRequestFilterBuilder> {
  _$ReceiptPagedRequestFilter? _$v;

  PagedRequestFieldBuilder? _date;
  PagedRequestFieldBuilder get date =>
      _$this._date ??= new PagedRequestFieldBuilder();
  set date(PagedRequestFieldBuilder? date) => _$this._date = date;

  PagedRequestFieldBuilder? _amount;
  PagedRequestFieldBuilder get amount =>
      _$this._amount ??= new PagedRequestFieldBuilder();
  set amount(PagedRequestFieldBuilder? amount) => _$this._amount = amount;

  PagedRequestFieldBuilder? _name;
  PagedRequestFieldBuilder get name =>
      _$this._name ??= new PagedRequestFieldBuilder();
  set name(PagedRequestFieldBuilder? name) => _$this._name = name;

  PagedRequestFieldBuilder? _paidBy;
  PagedRequestFieldBuilder get paidBy =>
      _$this._paidBy ??= new PagedRequestFieldBuilder();
  set paidBy(PagedRequestFieldBuilder? paidBy) => _$this._paidBy = paidBy;

  PagedRequestFieldBuilder? _categories;
  PagedRequestFieldBuilder get categories =>
      _$this._categories ??= new PagedRequestFieldBuilder();
  set categories(PagedRequestFieldBuilder? categories) =>
      _$this._categories = categories;

  PagedRequestFieldBuilder? _tags;
  PagedRequestFieldBuilder get tags =>
      _$this._tags ??= new PagedRequestFieldBuilder();
  set tags(PagedRequestFieldBuilder? tags) => _$this._tags = tags;

  PagedRequestFieldBuilder? _status;
  PagedRequestFieldBuilder get status =>
      _$this._status ??= new PagedRequestFieldBuilder();
  set status(PagedRequestFieldBuilder? status) => _$this._status = status;

  PagedRequestFieldBuilder? _resolvedDate;
  PagedRequestFieldBuilder get resolvedDate =>
      _$this._resolvedDate ??= new PagedRequestFieldBuilder();
  set resolvedDate(PagedRequestFieldBuilder? resolvedDate) =>
      _$this._resolvedDate = resolvedDate;

  PagedRequestFieldBuilder? _createdAt;
  PagedRequestFieldBuilder get createdAt =>
      _$this._createdAt ??= new PagedRequestFieldBuilder();
  set createdAt(PagedRequestFieldBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  ReceiptPagedRequestFilterBuilder() {
    ReceiptPagedRequestFilter._defaults(this);
  }

  ReceiptPagedRequestFilterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date?.toBuilder();
      _amount = $v.amount?.toBuilder();
      _name = $v.name?.toBuilder();
      _paidBy = $v.paidBy?.toBuilder();
      _categories = $v.categories?.toBuilder();
      _tags = $v.tags?.toBuilder();
      _status = $v.status?.toBuilder();
      _resolvedDate = $v.resolvedDate?.toBuilder();
      _createdAt = $v.createdAt?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReceiptPagedRequestFilter other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReceiptPagedRequestFilter;
  }

  @override
  void update(void Function(ReceiptPagedRequestFilterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReceiptPagedRequestFilter build() => _build();

  _$ReceiptPagedRequestFilter _build() {
    _$ReceiptPagedRequestFilter _$result;
    try {
      _$result = _$v ??
          new _$ReceiptPagedRequestFilter._(
              date: _date?.build(),
              amount: _amount?.build(),
              name: _name?.build(),
              paidBy: _paidBy?.build(),
              categories: _categories?.build(),
              tags: _tags?.build(),
              status: _status?.build(),
              resolvedDate: _resolvedDate?.build(),
              createdAt: _createdAt?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'date';
        _date?.build();
        _$failedField = 'amount';
        _amount?.build();
        _$failedField = 'name';
        _name?.build();
        _$failedField = 'paidBy';
        _paidBy?.build();
        _$failedField = 'categories';
        _categories?.build();
        _$failedField = 'tags';
        _tags?.build();
        _$failedField = 'status';
        _status?.build();
        _$failedField = 'resolvedDate';
        _resolvedDate?.build();
        _$failedField = 'createdAt';
        _createdAt?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReceiptPagedRequestFilter', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
