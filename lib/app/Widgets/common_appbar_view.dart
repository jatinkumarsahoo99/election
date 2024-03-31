import 'package:flutter/material.dart';

import '../AppTheme/Theme.dart';
import '../AppTheme/text_styles.dart';




class CommonAppbarView extends StatelessWidget {
  final double? topPadding;
  final Widget? backWidget;
  final String titleText;
  final VoidCallback? onBackClick;
  final IconData? iconData;

  const CommonAppbarView({
    Key? key,
    this.topPadding,
    this.onBackClick,
    this.titleText = '',
    this.backWidget,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: SizedBox(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: onBackClick,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 0),
                      child: backWidget ??
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppTheme.primaryTextColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 24, right: 24),
            child: Text(titleText, style: TextStyles(context).getTitleStyle().copyWith(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}

class CommonAppbarView1 extends StatelessWidget {
  final double? topPadding;
  final Widget? backWidget;
  final String titleText;
  final VoidCallback? onBackClick;
  final VoidCallback? calFun;
  final IconData? iconData;

  const CommonAppbarView1({
    Key? key,
    this.topPadding,
    this.onBackClick,
    this.calFun,
    this.titleText = '',
    this.backWidget,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppBar().preferredSize.height - 8,
                    height: AppBar().preferredSize.height - 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: onBackClick,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 0),
                          child: backWidget ??
                              Icon(
                                Icons.arrow_back_ios,
                                color: AppTheme.primaryTextColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppBar().preferredSize.height - 8,
                    height: AppBar().preferredSize.height - 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: calFun,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 0),
                          child: backWidget ??
                              Icon(
                                Icons.logout,
                                color: AppTheme.primaryTextColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 24, right: 24),
            child: Text(titleText, style: TextStyles(context).getTitleStyle().copyWith(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
