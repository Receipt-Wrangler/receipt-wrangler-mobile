//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertReceiptCommand {
  /// Returns a new [UpsertReceiptCommand] instance.
  UpsertReceiptCommand({
    required this.name,
    required this.amount,
    required this.date,
    required this.groupId,
    required this.paidByUserId,
    required this.status,
    this.categories = const [],
    this.tags = const [],
    this.receiptItems = const [],
    this.comments = const [],
  });

  /// Receipt name
  String name;

  /// Receipt total amount
  String amount;

  /// Receipt date
  String date;

  /// Group foreign key
  int groupId;

  /// User paid foreign key
  int paidByUserId;

  ReceiptStatus status;

  /// Categories associated to receipt
  List<UpsertCategoryCommand> categories;

  /// Tags associated to receipt
  List<UpsertTagCommand> tags;

  /// Items associated to receipt
  List<UpsertItemCommand> receiptItems;

  /// Comments associated to receipt
  List<UpsertCommentCommand> comments;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertReceiptCommand &&
     other.name == name &&
     other.amount == amount &&
     other.date == date &&
     other.groupId == groupId &&
     other.paidByUserId == paidByUserId &&
     other.status == status &&
     other.categories == categories &&
     other.tags == tags &&
     other.receiptItems == receiptItems &&
     other.comments == comments;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (amount.hashCode) +
    (date.hashCode) +
    (groupId.hashCode) +
    (paidByUserId.hashCode) +
    (status.hashCode) +
    (categories.hashCode) +
    (tags.hashCode) +
    (receiptItems.hashCode) +
    (comments.hashCode);

  @override
  String toString() => 'UpsertReceiptCommand[name=$name, amount=$amount, date=$date, groupId=$groupId, paidByUserId=$paidByUserId, status=$status, categories=$categories, tags=$tags, receiptItems=$receiptItems, comments=$comments]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'amount'] = this.amount;
      json[r'date'] = this.date;
      json[r'groupId'] = this.groupId;
      json[r'paidByUserId'] = this.paidByUserId;
      json[r'status'] = this.status;
      json[r'categories'] = this.categories;
      json[r'tags'] = this.tags;
      json[r'receiptItems'] = this.receiptItems;
      json[r'comments'] = this.comments;
    return json;
  }

  /// Returns a new [UpsertReceiptCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertReceiptCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertReceiptCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertReceiptCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertReceiptCommand(
        name: mapValueOfType<String>(json, r'name')!,
        amount: mapValueOfType<String>(json, r'amount')!,
        date: mapValueOfType<String>(json, r'date')!,
        groupId: mapValueOfType<int>(json, r'groupId')!,
        paidByUserId: mapValueOfType<int>(json, r'paidByUserId')!,
        status: ReceiptStatus.fromJson(json[r'status'])!,
        categories: UpsertCategoryCommand.listFromJson(json[r'categories']) ?? const [],
        tags: UpsertTagCommand.listFromJson(json[r'tags']) ?? const [],
        receiptItems: UpsertItemCommand.listFromJson(json[r'receiptItems']) ?? const [],
        comments: UpsertCommentCommand.listFromJson(json[r'comments']) ?? const [],
      );
    }
    return null;
  }

  static List<UpsertReceiptCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertReceiptCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertReceiptCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertReceiptCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertReceiptCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertReceiptCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertReceiptCommand-objects as value to a dart map
  static Map<String, List<UpsertReceiptCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertReceiptCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertReceiptCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'amount',
    'date',
    'groupId',
    'paidByUserId',
    'status',
  };
}

