import 'package:receipt_wrangler_mobile/api/api.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';

List<UserView> getUsersInGroup(
    UserModel userModel, GroupModel groupModel, String groupId) {
  var group = groupModel.getGroupById(groupId);
  if (group != null) {
    return group.groupMembers.map((member) {
      return userModel.getUserById(member.userId.toString()) ??
          UserView(
            id: 0,
            displayName: "Unknown User",
            userRole: UserRole.ADMIN,
            username: "",
            isDummyUser: false,
          );
    }).toList();
  }
  return [];
}