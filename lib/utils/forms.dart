import '../enums/form_state.dart';

WranglerFormState getFormState(String uri) {
  if (uri.contains("create")) {
    return WranglerFormState.create;
  } else if (uri.contains("edit")) {
    return WranglerFormState.edit;
  } else {
    return WranglerFormState.view;
  }
}

String getFormStateHeader(WranglerFormState formState) {
  switch (formState) {
    case WranglerFormState.create:
      return "Create";
    case WranglerFormState.edit:
      return "Edit";
    case WranglerFormState.view:
      return "View";
    default:
      return "View";
  }
}

bool isFieldReadOnly(WranglerFormState formState) {
  return formState == WranglerFormState.view;
}
