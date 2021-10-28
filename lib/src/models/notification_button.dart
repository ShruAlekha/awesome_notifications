import 'package:awesome_notifications/src/definitions.dart';
import 'package:awesome_notifications/src/enumerators/action_button_type.dart';
import 'package:awesome_notifications/src/enumerators/media_source.dart';
import 'package:awesome_notifications/src/models/model.dart';
import 'package:awesome_notifications/src/utils/assert_utils.dart';
import 'package:awesome_notifications/src/utils/bitmap_utils.dart';
import 'package:awesome_notifications/src/utils/string_utils.dart';

/// Notification button to display inside a notification.
/// Since Android 7, icons are displayed only for Media Layout Notifications
/// [icon] must be a native resource media type
///
/// [buttonType] could be classified in 4 types:
///
/// [ActionButtonType.Default]: after user taps, the notification bar is closed and an action event is fired.
/// [ActionButtonType.InputField]: after user taps, a input text field is displayed to capture input by the user.
/// [ActionButtonType.DisabledAction]: after user taps, the notification bar is closed, but the respective action event is not fired.
/// [ActionButtonType.KeepOnTop]: after user taps, the notification bar is not closed, but an action event is fired.
class NotificationActionButton extends Model {
  String? key;
  String? label;
  String? icon;
  bool? enabled;
  bool? autoDismissable;
  bool? showInCompactView;
  ActionButtonType? buttonType;

  NotificationActionButton({
      required this.key,
      required this.label,
      this.icon,
      this.enabled,
      this.autoDismissable,
      this.showInCompactView,
      this.buttonType = ActionButtonType.Default});

  @override
  NotificationActionButton? fromMap(Map<String, dynamic> dataMap) {
    key = AssertUtils.extractValue(NOTIFICATION_KEY, dataMap, String);
    icon = AssertUtils.extractValue(NOTIFICATION_ICON, dataMap, String);
    label = AssertUtils.extractValue(
        NOTIFICATION_BUTTON_LABEL, dataMap, String);
    enabled =
        AssertUtils.extractValue(NOTIFICATION_ENABLED, dataMap, bool);
    autoDismissable =
        AssertUtils.extractValue(NOTIFICATION_AUTO_DISMISSABLE, dataMap, bool);
    showInCompactView = AssertUtils.extractValue(
        NOTIFICATION_SHOW_IN_COMPACT_VIEW, dataMap, bool);
    buttonType = AssertUtils.extractEnum(
        NOTIFICATION_BUTTON_TYPE, dataMap, ActionButtonType.values);

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      NOTIFICATION_KEY: key,
      NOTIFICATION_ICON: icon,
      NOTIFICATION_BUTTON_LABEL: label,
      NOTIFICATION_ENABLED: enabled,
      NOTIFICATION_AUTO_DISMISSABLE: autoDismissable,
      NOTIFICATION_SHOW_IN_COMPACT_VIEW: showInCompactView,
      NOTIFICATION_BUTTON_TYPE: AssertUtils.toSimpleEnumString(buttonType)
    };
  }

  @override
  void validate() {
    assert(!AssertUtils.isNullOrEmptyOrInvalid(key, String));
    assert(!AssertUtils.isNullOrEmptyOrInvalid(label, String));
    assert(!AssertUtils.isNullOrEmptyOrInvalid(autoDismissable, bool));
    assert(!AssertUtils.isNullOrEmptyOrInvalid(showInCompactView, bool));

    // For action buttons, it's only allowed resource media types
    assert(StringUtils.isNullOrEmpty(icon) ||
        BitmapUtils().getMediaSource(icon!) == MediaSource.Resource);
  }
}
