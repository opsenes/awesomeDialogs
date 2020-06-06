library awesome_dialog;

import 'package:awesome_dialog/animated_button.dart';
import 'package:awesome_dialog/anims/flare_header.dart';
import 'package:awesome_dialog/vertical_stack_header_dialog.dart';
import 'package:flutter/material.dart';

import 'anims/anims.dart';

enum DialogType { INFO, WARNING, ERROR, SUCCESS }
enum AnimType { SCALE, LEFT_SLIDE, RIGHT_SLIDE, BOTTOM_SLIDE, TOP_SLIDE }

class AwesomeDialog {
  final DialogType dialogType;
  final Widget customHeader;
  final String tittle;
  final String desc;
  final BuildContext context;
  final String btnOkText;
  final IconData btnOkIcon;
  final Function btnOkOnPress;
  final Color btnOkColor;
  final String btnCancelText;
  final IconData btnCancelIcon;
  final Function btnCancelOnPress;
  final Color btnCancelColor;
  final Widget btnOk;
  final Widget btnCancel;
  final Widget body;
  final bool dismissOnTouchOutside;
  final Function onDismissCallback;
  final AnimType animType;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry dialogPadding;
  final bool isDense;
  final bool headerAnimationLoop;
  final bool useRootNavigator;

  AwesomeDialog(
      {@required this.context,
      this.dialogType,
      this.customHeader,
      this.tittle,
      this.desc,
      this.body,
      this.btnOk,
      this.btnCancel,
      this.btnOkText,
      this.btnOkIcon,
      this.btnOkOnPress,
      this.btnOkColor,
      this.btnCancelText,
      this.btnCancelIcon,
      this.btnCancelOnPress,
      this.btnCancelColor,
      this.onDismissCallback,
      this.isDense = false,
      this.dismissOnTouchOutside = true,
      this.headerAnimationLoop = true,
      this.alignment = Alignment.center,
      this.animType = AnimType.SCALE,
      this.contentPadding,
      this.dialogPadding,
      this.useRootNavigator = false})
      : assert(
          (dialogType != null || customHeader != null),
          context != null,
        );

  Future show() {
    return showDialog(
        context: this.context,
        barrierDismissible: dismissOnTouchOutside,
        builder: (BuildContext context) {
          switch (animType) {
            case AnimType.SCALE:
              return ScaleFade(
                  scale: 0.1,
                  fade: true,
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: _buildDialog());
              break;
            case AnimType.LEFT_SLIDE:
              return FadeIn(from: SlideFrom.LEFT, child: _buildDialog());
              break;
            case AnimType.RIGHT_SLIDE:
              return FadeIn(from: SlideFrom.RIGHT, child: _buildDialog());
              break;
            case AnimType.BOTTOM_SLIDE:
              return FadeIn(from: SlideFrom.BOTTOM, child: _buildDialog());
              break;
            case AnimType.TOP_SLIDE:
              return FadeIn(from: SlideFrom.TOP, child: _buildDialog());
              break;
            default:
              return _buildDialog();
          }
        }).then((_) {
      if (onDismissCallback != null) onDismissCallback();
    });
  }

  _buildDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        return VerticalStackDialog(
          header: customHeader ??
              FlareHeader(
                loop: headerAnimationLoop,
                dialogType: this.dialogType,
              ),
          title: this.tittle,
          desc: this.desc,
          body: this.body,
          isDense: isDense,
          alignment: alignment,
          dialogPadding: dialogPadding,
          contentPadding: contentPadding ?? EdgeInsets.only(left: 5, right: 5),
          btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk() : null),
          btnCancel: btnCancel ??
              (btnCancelOnPress != null ? _buildFancyButtonCancel() : null),
        );
      },
    );
  }

  _buildFancyButtonOk() {
    return AnimatedButton(
      pressEvent: () {
        Navigator.of(context, rootNavigator: useRootNavigator).pop();
        btnOkOnPress();
      },
      text: btnOkText ?? 'Ok',
      color: btnOkColor ?? Color(0xFF00CA71),
      icon: btnOkIcon,
    );
  }

  _buildFancyButtonCancel() {
    return AnimatedButton(
      pressEvent: () {
        Navigator.of(context, rootNavigator: useRootNavigator).pop();
        btnCancelOnPress();
      },
      text: btnCancelText ?? 'Cancel',
      color: btnCancelColor ?? Colors.red,
      icon: btnCancelIcon,
    );
  }

  dismiss() {
    Navigator.of(context, rootNavigator: useRootNavigator).pop();
  }
}
