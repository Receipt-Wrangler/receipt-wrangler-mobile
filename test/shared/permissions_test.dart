import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/shared/functions/permissions.dart';

class _FakeAuthModel extends AuthModel {
  api.Claims? _fakeClaims;

  @override
  api.Claims? get claims => _fakeClaims;

  @override
  void setClaims(api.Claims claims) {
    _fakeClaims = claims;
  }
}

api.GroupMember _member({required int groupId, required int userId, required api.GroupRole role}) {
  return (api.GroupMemberBuilder()
        ..groupId = groupId
        ..userId = userId
        ..groupRole = role)
      .build();
}

api.Group _group({
  required int id,
  required String name,
  required List<api.GroupMember> members,
}) {
  return (api.GroupBuilder()
        ..id = id
        ..name = name
        ..isAllGroup = false
        ..status = api.GroupStatus.ACTIVE
        ..groupMembers.replace(members)
        ..groupReceiptSettings.replace((api.GroupReceiptSettingsBuilder()
              ..id = id
              ..groupId = id
              ..createdAt = '2024-01-01T00:00:00Z'
              ..hideReceiptCategories = false
              ..hideReceiptTags = false
              ..hideItemCategories = false
              ..hideItemTags = false)
            .build())
      )
      .build();
}

void main() {
  group('permissions', () {
    test('canEditReceipt: true for OWNER and EDITOR, false otherwise', () {
      final auth = _FakeAuthModel();
      final groups = GroupModel();

      auth.setClaims((api.ClaimsBuilder()..userId = 1).build());
      final g = _group(
        id: 100,
        name: 'G',
        members: [
          _member(groupId: 100, userId: 1, role: api.GroupRole.OWNER),
        ],
      );
      groups.setGroups([g]);

      expect(canEditReceipt(auth, groups, 100), isTrue);

      // Change role to EDITOR
      final g2 = _group(
        id: 101,
        name: 'G2',
        members: [
          _member(groupId: 101, userId: 1, role: api.GroupRole.EDITOR),
        ],
      );
      groups.setGroups([g2]);
      expect(canEditReceipt(auth, groups, 101), isTrue);

      // VIEWER should be false
      final g3 = _group(
        id: 102,
        name: 'G3',
        members: [
          _member(groupId: 102, userId: 1, role: api.GroupRole.VIEWER),
        ],
      );
      groups.setGroups([g3]);
      expect(canEditReceipt(auth, groups, 102), isFalse);
    });

    test('getUserRoleInGroup returns null when user not in group', () {
      final groups = GroupModel();
      final g = _group(
        id: 200,
        name: 'G',
        members: [
          _member(groupId: 200, userId: 2, role: api.GroupRole.VIEWER),
        ],
      );
      groups.setGroups([g]);

      // Should not throw and should return null
      final role = getUserRoleInGroup(999, 200, groups);
      expect(role, isNull);
    });

    test('canEditReceipt returns false when no claims/userId', () {
      final auth = _FakeAuthModel();
      final groups = GroupModel();
      groups.setGroups([
        _group(id: 1, name: 'X', members: []),
      ]);

      expect(canEditReceipt(auth, groups, 1), isFalse);
    });
  });
}
