import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/text_styles.dart';

class OkDialog {
  BuildContext context;
  String? title;
  String message;
  Function? okFunction;
  bool? showIcon;

  OkDialog({
    required this.context,
    this.title,
    required this.message,
    this.okFunction,
    this.showIcon,
  });

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title != null ?
              Text(
                title!,
                style: HeadingTextStyles.headingS(),
              ) :
              const Material(),
              showIcon != null ?
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0,),
                child: showIcon == true ?
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60.0,
                ) :
                const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 60.0,
                ),
              ) :
              const Material(),
              title != null || showIcon != null ?
              const SizedBox(
                height: 10.0,
              ) :
              const Material(),
              Text(
                message,
                style: MTextStyles.regular(),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                BackFromThisPage(context: context).go();
              },
              child: const Text('Mengerti'),
            ),
          ],
        );
      },
    ).then((_) {
      if(okFunction != null) {
        okFunction!();
      }
    });
  }
}

class OptionDialog {
  BuildContext context;
  String message;
  Function yesFunction;
  Function noFunction;

  OptionDialog({
    required this.context,
    required this.message,
    required this.yesFunction,
    required this.noFunction,
  });

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Perhatian',
          ),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                noFunction();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                yesFunction();
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}

class LoadingDialog {
  BuildContext context;

  LoadingDialog({required this.context});

  Future<bool> onBackPressed() async {
    return Future.value(false);
  }

  void show() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: onBackPressed,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Sedang memuat, mohon tunggu...',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ErrorHandler {
  BuildContext context;
  DioError dioErr;

  ErrorHandler({
    required this.context,
    required this.dioErr,
  });

  void handle() {
    int? errCode;
    String errMessage = 'Unknown Error.\n\nTerjadi kesalahan yang tak diketahui, silahkan hubungi Admin untuk informasi lebih lanjut.';

    if(dioErr.response != null) {
      errCode = dioErr.response!.statusCode;

      switch(errCode) {
        case 401:
          errMessage = 'Unauthorized.\n\nAnda tidak memiliki hak untuk mengakses konten, silahkan hubungi Admin untuk informasi lebih lanjut.';
          break;
        case 422:
          errMessage = 'Unprocessable Entity.\n\nTerdapat kesalahan pada data yang hendak Anda kirim, mohon periksa kembali data Anda dan coba lagi.';
          break;
        case 404:
          errMessage = 'Not Found.\n\nPermintaan tidak ditemukan, silahkan hubungi Admin untuk informasi lebih lanjut.';
          break;
        case 500:
          errMessage = 'Internal Server Error.\n\nTerjadi kesalahan pada server, silahkan hubungi Admin untuk informasi lebih lanjut.';
          break;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                '(${errCode ?? '-'}) $errMessage',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}