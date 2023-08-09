import 'package:flutter/material.dart';
import 'package:kenari_app/services/local/models/local_status_color_data.dart';
import 'package:kenari_app/styles/color_styles.dart';

LocalStatusColorData checkStatusColor(String? status) {
  LocalStatusColorData result;

  if(status != null) {
    if(status.contains('waiting')) {
      result = LocalStatusColorData(
        surface: WarningColorStyles.warningSurface(),
        border: WarningColorStyles.warningBorder(),
        main: WarningColorStyles.warningMain(),
      );
    } else if(status.contains('on proccess') || status.contains('ready to pickup')) {
      result = LocalStatusColorData(
        surface: InfoColorStyles.infoSurface(),
        border: InfoColorStyles.infoBorder(),
        main: InfoColorStyles.infoMain(),
      );
    } else if(status.contains('done')) {
      result = LocalStatusColorData(
        surface: SuccessColorStyles.successSurface(),
        border: SuccessColorStyles.successBorder(),
        main: SuccessColorStyles.successMain(),
      );
    } else if(status.contains('cancel')) {
      result = LocalStatusColorData(
        surface: DangerColorStyles.dangerSurface(),
        border: DangerColorStyles.dangerBorder(),
        main: DangerColorStyles.dangerMain(),
      );
    } else {
      result = const LocalStatusColorData(
        surface: Colors.white,
        border: Colors.black54,
        main: Colors.black,
      );
    }
  } else {
    result = const LocalStatusColorData(
      surface: Colors.white,
      border: Colors.black54,
      main: Colors.black,
    );
  }

  return result;
}