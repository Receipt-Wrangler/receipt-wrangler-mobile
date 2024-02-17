import '../enums/form_state.dart';

FormState getFormState(String uri) {
  if (uri.contains("create")) {
    return FormState.create;
  } else if (uri.contains("edit")) {
    return FormState.edit;
  } else {
    return FormState.view;
  }
}

String getFormStateHeader(FormState formState) {
  switch (formState) {
    case FormState.create:
      return "Create";
    case FormState.edit:
      return "Edit";
    case FormState.view:
      return "View";
    default:
      return "View";
  }
}
