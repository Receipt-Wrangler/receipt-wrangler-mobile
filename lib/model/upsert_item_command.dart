//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertItemCommand {
  /// Returns a new [UpsertItemCommand] instance.
  UpsertItemCommand({
    required this.amount,
    required this.chargedToUserId,
    required this.name,
    required this.receiptId,
    required this.status,
  });

  /// Amount the item costs
  String amount;

  /// User foreign key
  int chargedToUserId;

  /// Item name
  String name;

  /// Receipt foreign key
  int receiptId;

  ItemStatus status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertItemCommand &&
     other.amount == amount &&
     other.chargedToUserId == chargedToUserId &&
     other.name == name &&
     other.receiptId == receiptId &&
     other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (amount.hashCode) +
    (chargedToUserId.hashCode) +
    (name.hashCode) +
    (receiptId.hashCode) +
    (status.hashCode);

  @override
  String toString() => 'UpsertItemCommand[amount=$amount, chargedToUserId=$chargedToUserId, name=$name, receiptId=$receiptId, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'amount'] = this.amount;
      json[r'chargedToUserId'] = this.chargedToUserId;
      json[r'name'] = this.name;
      json[r'receiptId'] = this.receiptId;
      json[r'status'] = this.status;
    return json;
  }

  /// Returns a new [UpsertItemCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertItemCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertItemCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertItemCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertItemCommand(
        amount: mapValueOfType<String>(json, r'amount')!,
        chargedToUserId: mapValueOfType<int>(json, r'chargedToUserId')!,
        name: mapValueOfType<String>(json, r'name')!,
        receiptId: mapValueOfType<int>(json, r'receiptId')!,
        status: ItemStatus.fromJson(json[r'status'])!,
      );
    }
    return null;
  }

  static List<UpsertItemCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertItemCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertItemCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertItemCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertItemCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertItemCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertItemCommand-objects as value to a dart map
  static Map<String, List<UpsertItemCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertItemCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertItemCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'amount',
    'chargedToUserId',
    'name',
    'receiptId',
    'status',
  };
}

