//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Item {
  /// Returns a new [Item] instance.
  Item({
    this.isTaxed,
    required this.amount,
    required this.chargedToUserId,
    this.createdAt,
    this.createdBy,
    this.id,
    required this.name,
    required this.receiptId,
    required this.status,
    this.updatedAt,
  });

  /// Is taxed (not used)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isTaxed;

  /// Amount the item costs
  String amount;

  /// User foreign key
  int chargedToUserId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? createdBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  /// Item name
  String name;

  /// Receipt foreign key
  int receiptId;

  ItemStatus status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Item &&
    other.isTaxed == isTaxed &&
    other.amount == amount &&
    other.chargedToUserId == chargedToUserId &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.id == id &&
    other.name == name &&
    other.receiptId == receiptId &&
    other.status == status &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (isTaxed == null ? 0 : isTaxed!.hashCode) +
    (amount.hashCode) +
    (chargedToUserId.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (id == null ? 0 : id!.hashCode) +
    (name.hashCode) +
    (receiptId.hashCode) +
    (status.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'Item[isTaxed=$isTaxed, amount=$amount, chargedToUserId=$chargedToUserId, createdAt=$createdAt, createdBy=$createdBy, id=$id, name=$name, receiptId=$receiptId, status=$status, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.isTaxed != null) {
      json[r'IsTaxed'] = this.isTaxed;
    } else {
      json[r'IsTaxed'] = null;
    }
      json[r'amount'] = this.amount;
      json[r'chargedToUserId'] = this.chargedToUserId;
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt;
    } else {
      json[r'createdAt'] = null;
    }
    if (this.createdBy != null) {
      json[r'createdBy'] = this.createdBy;
    } else {
      json[r'createdBy'] = null;
    }
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
      json[r'name'] = this.name;
      json[r'receiptId'] = this.receiptId;
      json[r'status'] = this.status;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [Item] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Item? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Item[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Item[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Item(
        isTaxed: mapValueOfType<bool>(json, r'IsTaxed'),
        amount: mapValueOfType<String>(json, r'amount')!,
        chargedToUserId: mapValueOfType<int>(json, r'chargedToUserId')!,
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        id: mapValueOfType<int>(json, r'id'),
        name: mapValueOfType<String>(json, r'name')!,
        receiptId: mapValueOfType<int>(json, r'receiptId')!,
        status: ItemStatus.fromJson(json[r'status'])!,
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
      );
    }
    return null;
  }

  static List<Item> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Item>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Item.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Item> mapFromJson(dynamic json) {
    final map = <String, Item>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Item.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Item-objects as value to a dart map
  static Map<String, List<Item>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Item>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Item.listFromJson(entry.value, growable: growable,);
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

