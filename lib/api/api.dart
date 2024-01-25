//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/auth_api.dart';
part 'api/category_api.dart';
part 'api/comment_api.dart';
part 'api/dashboard_api.dart';
part 'api/feature_config_api.dart';
part 'api/groups_api.dart';
part 'api/notifications_api.dart';
part 'api/receipt_api.dart';
part 'api/receipt_image_api.dart';
part 'api/search_api.dart';
part 'api/tag_api.dart';
part 'api/user_api.dart';
part 'api/user_preferences_api.dart';

part 'model/app_data.dart';
part 'model/base_model.dart';
part 'model/bulk_status_update_command.dart';
part 'model/category.dart';
part 'model/category_view.dart';
part 'model/comment.dart';
part 'model/dashboard.dart';
part 'model/encoded_image.dart';
part 'model/feature_config.dart';
part 'model/file_data.dart';
part 'model/file_data_view.dart';
part 'model/filter_operations.dart';
part 'model/group.dart';
part 'model/group_member.dart';
part 'model/group_role.dart';
part 'model/group_settings.dart';
part 'model/group_settings_white_list_email.dart';
part 'model/group_status.dart';
part 'model/item.dart';
part 'model/item_status_enum.dart';
part 'model/login_command.dart';
part 'model/magic_fill_command.dart';
part 'model/notification.dart';
part 'model/paged_data.dart';
part 'model/paged_request_command.dart';
part 'model/paged_request_field.dart';
part 'model/paged_request_field_value.dart';
part 'model/receipt.dart';
part 'model/receipt_paged_request_command.dart';
part 'model/receipt_paged_request_filter.dart';
part 'model/receipt_status.dart';
part 'model/reset_password_command.dart';
part 'model/search_result.dart';
part 'model/sign_up_command.dart';
part 'model/sort_direction.dart';
part 'model/subject_line_regex.dart';
part 'model/tag.dart';
part 'model/tag_view.dart';
part 'model/update_group_settings_command.dart';
part 'model/update_profile_command.dart';
part 'model/upsert_dashboard_command.dart';
part 'model/upsert_tag_command.dart';
part 'model/upsert_widget_command.dart';
part 'model/user.dart';
part 'model/user_preferences.dart';
part 'model/user_role_enum.dart';
part 'model/user_view.dart';
part 'model/widget.dart';
part 'model/widget_type.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
