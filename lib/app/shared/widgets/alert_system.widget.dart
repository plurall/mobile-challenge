import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/shared/utils/colors.dart';
import 'package:mobile_challenge/app/shared/utils/constants.dart';
import 'package:mobile_challenge/app/shared/utils/constrains.dart';
import 'package:mobile_challenge/app/shared/utils/fonts.dart';

class AlertSystem {
  Dialog createTemplate(
      {Widget child,
      String title,
      String subTitle,
      String successName,
      String cancelName,
      bool haveOptions,
      context,
      onSuccess,
      onCancel}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: Constrains.layoutSpace(LayoutSpace.s)),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Constrains.layoutSpace(LayoutSpace.m)),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: Fonts.fontSize(FontsSize.section),
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: Constrains.layoutSpace(LayoutSpace.xxs)),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Constrains.layoutSpace(LayoutSpace.m)),
                child: Text(subTitle)),
            SizedBox(height: Constrains.layoutSpace(LayoutSpace.xs)),
            child == null ? Container() : child,
            SizedBox(height: Constrains.layoutSpace(LayoutSpace.xs)),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onSuccess();
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: Container(
                      padding: EdgeInsets.all(
                          Constrains.layoutSpace(LayoutSpace.xxs)),
                      margin: EdgeInsets.symmetric(
                          horizontal: Constrains.layoutSpace(LayoutSpace.xs)),
                      decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        successName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Fonts.button,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )),
                )),
            haveOptions
                ? Column(
                    children: [
                      SizedBox(height: Constrains.layoutSpace(LayoutSpace.s)),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          onCancel();
                        },
                        child: Text(
                          cancelName == null ? Constants.CANCEL : cancelName,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: Constrains.layoutSpace(LayoutSpace.s)),
          ],
        ),
      ),
    );
  }

  normal({
    @required String title,
    @required String subTitle,
    @required context,
    @required Function onSuccess,
    Function onCancel,
    String successName,
    String cancelName,
    Widget child,
    bool haveOptions = false,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) => createTemplate(
            child: child,
            title: title,
            subTitle: subTitle,
            context: context,
            onSuccess: onSuccess,
            onCancel: onCancel,
            successName: successName,
            cancelName: cancelName,
            haveOptions: haveOptions));
  }
}
