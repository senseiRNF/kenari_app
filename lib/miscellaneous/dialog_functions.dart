import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/splash_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class OkDialog {
  BuildContext context;
  String? title;
  String message;
  String? okText;
  Function? okFunction;
  bool? showIcon;
  bool? hideButton;

  OkDialog({
    required this.context,
    this.title,
    required this.message,
    this.okText,
    this.okFunction,
    this.showIcon,
    this.hideButton,
  });

  Future show() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    title != null || showIcon != null ?
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showIcon != null ?
                          Row(
                            children: [
                              showIcon == true ?
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30.0,
                              ) :
                              const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 30.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ) :
                          const Material(),
                          Expanded(
                            child: title != null ?
                            Text(
                              title!,
                              style: HeadingTextStyles.headingS(),
                            ) :
                            const Material(),
                          ),
                        ],
                      ),
                    ) :
                    const Material(),
                    Text(
                      message,
                      style: MTextStyles.regular(),
                    ),
                  ],
                ),
              ),
              hideButton == null || hideButton == false ?
              Container(
                decoration: BoxDecoration(
                  color: NeutralColorStyles.neutral02(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          BackFromThisPage(context: context).go();
                        },
                        child: Text(
                          okText ?? 'Mengerti',
                        ),
                      ),
                    ],
                  ),
                ),
              ) :
              const Material(),
            ],
          ),
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
  String? title;
  String message;
  String? yesText;
  Function yesFunction;
  String? noText;
  Function? noFunction;

  OptionDialog({
    required this.context,
    this.title,
    required this.message,
    this.yesText,
    required this.yesFunction,
    this.noText,
    this.noFunction,
  });

  Future show() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      title ?? 'Perhatian',
                      style: HeadingTextStyles.headingS(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      message,
                      style: MTextStyles.regular(),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: NeutralColorStyles.neutral02(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          if(noFunction != null) {
                            noFunction!();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          noText ?? 'Tidak',
                          style: TextStyle(
                            color: NeutralColorStyles.neutral09(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          yesFunction();
                        },
                        child: Text(
                          yesText ?? 'Ya',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
              children: [
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Sedang memuat, mohon tunggu...',
                  style: MTextStyles.regular(),
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
  DioException dioExc;
  bool? isLoginService;

  ErrorHandler({
    required this.context,
    required this.dioExc,
    this.isLoginService,
  });

  void handle() {
    int? errCode;
    String? serverErrMessage;
    String? errMessage;

    if(dioExc.response != null) {
      errCode = dioExc.response!.statusCode;

      if(dioExc.response!.data != null && dioExc.response!.data['message'] != null && dioExc.response!.data['message'] != '') {
        serverErrMessage = dioExc.response!.data['message'];
      }

      switch(errCode) {
        case 401:
          if(serverErrMessage != null) {
            errMessage = 'Unauthorized.\n\n$serverErrMessage';
          } else {
            errMessage = 'Unauthorized.\n\nAnda tidak memiliki hak untuk mengakses konten, silahkan hubungi Admin untuk informasi lebih lanjut.';
          }
          break;
        case 422:
          if(serverErrMessage != null) {
            errMessage = 'Unprocessable Entity.\n\n$serverErrMessage';
          } else {
            errMessage = 'Unprocessable Entity.\n\nTerdapat kesalahan pada data yang hendak Anda kirim, mohon periksa kembali data Anda dan coba lagi.';
          }
          break;
        case 404:
          if(serverErrMessage != null) {
            errMessage = 'Not Found.\n\n$serverErrMessage';
          } else {
            errMessage = 'Not Found.\n\nPermintaan tidak ditemukan, silahkan hubungi Admin untuk informasi lebih lanjut.';
          }

          break;
        case 500:
          if(serverErrMessage != null) {
            errMessage = 'Internal Server Error.\n\n$serverErrMessage';
          } else {
            errMessage = 'Internal Server Error.\n\nTerjadi kesalahan pada server, silahkan hubungi Admin untuk informasi lebih lanjut.';
          }
          break;
        default:
          if(serverErrMessage != null) {
            errMessage = 'Unknown Error.\n\n$serverErrMessage';
          } else {
            errMessage = 'Unknown Error.\n\nTerjadi kesalahan yang tak diketahui, silahkan hubungi Admin untuk informasi lebih lanjut.';
          }
          break;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                child: Center(
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Text(
                  '(${errCode ?? '-'}) $errMessage',
                  style: MTextStyles.regular(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: NeutralColorStyles.neutral02(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          BackFromThisPage(context: context).go();
                        },
                        child: const Text(
                          'OK',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      if(errCode != null && errCode == 401) {
        if(isLoginService == null && isLoginService == false) {
          RedirectToPage(context: context, target: const SplashPage()).go();
        }
      }
    });
  }
}

class SourceSelectionDialog {
  BuildContext context;
  String? title;
  String message;
  Function cameraFunction;
  Function galleryFunction;

  SourceSelectionDialog({
    required this.context,
    this.title,
    required this.message,
    required this.cameraFunction,
    required this.galleryFunction,
  });

  Future show() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      title ?? 'Perhatian',
                      style: HeadingTextStyles.headingS(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      message,
                      style: MTextStyles.regular(),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: NeutralColorStyles.neutral02(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          galleryFunction();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Galeri',
                          style: TextStyle(
                            color: NeutralColorStyles.neutral09(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          cameraFunction();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Kamera',
                          style: TextStyle(
                            color: NeutralColorStyles.neutral09(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SuccessDialog {
  BuildContext context;
  String message;
  Function? okFunction;

  SuccessDialog({
    required this.context,
    required this.message,
    this.okFunction,
  });

  Future show() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 80.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        message,
                        style: HeadingTextStyles.headingS(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      if(okFunction != null) {
        okFunction!();
      }
    });
  }
}