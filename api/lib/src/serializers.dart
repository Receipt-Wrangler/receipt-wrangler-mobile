//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/about.dart';
import 'package:openapi/src/model/activity.dart';
import 'package:openapi/src/model/ai_type.dart';
import 'package:openapi/src/model/app_data.dart';
import 'package:openapi/src/model/associated_entity_type.dart';
import 'package:openapi/src/model/associated_group.dart';
import 'package:openapi/src/model/base_model.dart';
import 'package:openapi/src/model/bulk_status_update_command.dart';
import 'package:openapi/src/model/category.dart';
import 'package:openapi/src/model/category_view.dart';
import 'package:openapi/src/model/check_email_connectivity_command.dart';
import 'package:openapi/src/model/check_receipt_processing_settings_connectivity_command.dart';
import 'package:openapi/src/model/claims.dart';
import 'package:openapi/src/model/comment.dart';
import 'package:openapi/src/model/currency_separator.dart';
import 'package:openapi/src/model/currency_symbol_position.dart';
import 'package:openapi/src/model/custom_field.dart';
import 'package:openapi/src/model/custom_field_option.dart';
import 'package:openapi/src/model/custom_field_type.dart';
import 'package:openapi/src/model/custom_field_value.dart';
import 'package:openapi/src/model/dashboard.dart';
import 'package:openapi/src/model/encoded_image.dart';
import 'package:openapi/src/model/export_format.dart';
import 'package:openapi/src/model/feature_config.dart';
import 'package:openapi/src/model/file_data.dart';
import 'package:openapi/src/model/file_data_view.dart';
import 'package:openapi/src/model/filter_operation.dart';
import 'package:openapi/src/model/get_new_refresh_token200_response.dart';
import 'package:openapi/src/model/get_system_task_command.dart';
import 'package:openapi/src/model/group.dart';
import 'package:openapi/src/model/group_filter.dart';
import 'package:openapi/src/model/group_member.dart';
import 'package:openapi/src/model/group_receipt_settings.dart';
import 'package:openapi/src/model/group_role.dart';
import 'package:openapi/src/model/group_settings.dart';
import 'package:openapi/src/model/group_settings_white_list_email.dart';
import 'package:openapi/src/model/group_status.dart';
import 'package:openapi/src/model/icon.dart';
import 'package:openapi/src/model/import_type.dart';
import 'package:openapi/src/model/internal_error_response.dart';
import 'package:openapi/src/model/item.dart';
import 'package:openapi/src/model/item_status.dart';
import 'package:openapi/src/model/login_command.dart';
import 'package:openapi/src/model/logout_command.dart';
import 'package:openapi/src/model/magic_fill_command.dart';
import 'package:openapi/src/model/notification.dart';
import 'package:openapi/src/model/ocr_engine.dart';
import 'package:openapi/src/model/paged_activity_request_command.dart';
import 'package:openapi/src/model/paged_data.dart';
import 'package:openapi/src/model/paged_data_data_inner.dart';
import 'package:openapi/src/model/paged_group_request_command.dart';
import 'package:openapi/src/model/paged_request_command.dart';
import 'package:openapi/src/model/prompt.dart';
import 'package:openapi/src/model/queue_name.dart';
import 'package:openapi/src/model/receipt.dart';
import 'package:openapi/src/model/receipt_paged_request_command.dart';
import 'package:openapi/src/model/receipt_paged_request_filter.dart';
import 'package:openapi/src/model/receipt_processing_settings.dart';
import 'package:openapi/src/model/receipt_status.dart';
import 'package:openapi/src/model/reset_password_command.dart';
import 'package:openapi/src/model/search_result.dart';
import 'package:openapi/src/model/sign_up_command.dart';
import 'package:openapi/src/model/sort_direction.dart';
import 'package:openapi/src/model/subject_line_regex.dart';
import 'package:openapi/src/model/system_email.dart';
import 'package:openapi/src/model/system_settings.dart';
import 'package:openapi/src/model/system_task.dart';
import 'package:openapi/src/model/system_task_status.dart';
import 'package:openapi/src/model/system_task_type.dart';
import 'package:openapi/src/model/tag.dart';
import 'package:openapi/src/model/tag_view.dart';
import 'package:openapi/src/model/task_queue_configuration.dart';
import 'package:openapi/src/model/token_pair.dart';
import 'package:openapi/src/model/update_group_receipt_settings_command.dart';
import 'package:openapi/src/model/update_group_settings_command.dart';
import 'package:openapi/src/model/update_profile_command.dart';
import 'package:openapi/src/model/upsert_category_command.dart';
import 'package:openapi/src/model/upsert_comment_command.dart';
import 'package:openapi/src/model/upsert_custom_field_command.dart';
import 'package:openapi/src/model/upsert_custom_field_option_command.dart';
import 'package:openapi/src/model/upsert_custom_field_value_command.dart';
import 'package:openapi/src/model/upsert_dashboard_command.dart';
import 'package:openapi/src/model/upsert_group_command.dart';
import 'package:openapi/src/model/upsert_group_member_command.dart';
import 'package:openapi/src/model/upsert_item_command.dart';
import 'package:openapi/src/model/upsert_prompt_command.dart';
import 'package:openapi/src/model/upsert_receipt_command.dart';
import 'package:openapi/src/model/upsert_receipt_processing_settings_command.dart';
import 'package:openapi/src/model/upsert_system_email_command.dart';
import 'package:openapi/src/model/upsert_system_settings_command.dart';
import 'package:openapi/src/model/upsert_tag_command.dart';
import 'package:openapi/src/model/upsert_task_queue_configuration.dart';
import 'package:openapi/src/model/upsert_widget_command.dart';
import 'package:openapi/src/model/user.dart';
import 'package:openapi/src/model/user_preferences.dart';
import 'package:openapi/src/model/user_role.dart';
import 'package:openapi/src/model/user_shortcut.dart';
import 'package:openapi/src/model/user_view.dart';
import 'package:openapi/src/model/widget.dart';
import 'package:openapi/src/model/widget_type.dart';

part 'serializers.g.dart';

@SerializersFor([
  About,
  Activity,
  AiType,
  AppData,
  AssociatedEntityType,
  AssociatedGroup,
  BaseModel,$BaseModel,
  BulkStatusUpdateCommand,
  Category,
  CategoryView,
  CheckEmailConnectivityCommand,
  CheckReceiptProcessingSettingsConnectivityCommand,
  Claims,
  Comment,
  CurrencySeparator,
  CurrencySymbolPosition,
  CustomField,
  CustomFieldOption,
  CustomFieldType,
  CustomFieldValue,
  Dashboard,
  EncodedImage,
  ExportFormat,
  FeatureConfig,
  FileData,
  FileDataView,
  FilterOperation,
  GetNewRefreshToken200Response,
  GetSystemTaskCommand,
  Group,
  GroupFilter,
  GroupMember,
  GroupReceiptSettings,
  GroupRole,
  GroupSettings,
  GroupSettingsWhiteListEmail,
  GroupStatus,
  Icon,
  ImportType,
  InternalErrorResponse,
  Item,
  ItemStatus,
  LoginCommand,
  LogoutCommand,
  MagicFillCommand,
  Notification,
  OcrEngine,
  PagedActivityRequestCommand,
  PagedData,
  PagedDataDataInner,
  PagedGroupRequestCommand,
  PagedRequestCommand,$PagedRequestCommand,
  Prompt,
  QueueName,
  Receipt,
  ReceiptPagedRequestCommand,
  ReceiptPagedRequestFilter,
  ReceiptProcessingSettings,
  ReceiptStatus,
  ResetPasswordCommand,
  SearchResult,
  SignUpCommand,
  SortDirection,
  SubjectLineRegex,
  SystemEmail,
  SystemSettings,
  SystemTask,
  SystemTaskStatus,
  SystemTaskType,
  Tag,
  TagView,
  TaskQueueConfiguration,
  TokenPair,
  UpdateGroupReceiptSettingsCommand,
  UpdateGroupSettingsCommand,
  UpdateProfileCommand,
  UpsertCategoryCommand,
  UpsertCommentCommand,
  UpsertCustomFieldCommand,
  UpsertCustomFieldOptionCommand,
  UpsertCustomFieldValueCommand,
  UpsertDashboardCommand,
  UpsertGroupCommand,
  UpsertGroupMemberCommand,
  UpsertItemCommand,
  UpsertPromptCommand,
  UpsertReceiptCommand,
  UpsertReceiptProcessingSettingsCommand,
  UpsertSystemEmailCommand,
  UpsertSystemSettingsCommand,
  UpsertTagCommand,
  UpsertTaskQueueConfiguration,
  UpsertWidgetCommand,
  User,
  UserPreferences,
  UserRole,
  UserShortcut,
  UserView,
  Widget,
  WidgetType,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(String)]),
        () => MapBuilder<String, String>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Group)]),
        () => ListBuilder<Group>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SearchResult)]),
        () => ListBuilder<SearchResult>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ReceiptStatus)]),
        () => ListBuilder<ReceiptStatus>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Dashboard)]),
        () => ListBuilder<Dashboard>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(int)]),
        () => ListBuilder<int>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Notification)]),
        () => ListBuilder<Notification>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Receipt)]),
        () => ListBuilder<Receipt>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Category)]),
        () => ListBuilder<Category>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Tag)]),
        () => ListBuilder<Tag>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UserView)]),
        () => ListBuilder<UserView>(),
      )
      ..add(BaseModel.serializer)
      ..add(PagedRequestCommand.serializer)
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
