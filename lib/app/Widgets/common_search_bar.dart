import 'package:flutter/material.dart';

import '../AppTheme/Theme.dart';
import '../AppTheme/text_styles.dart';




class CommonSearchBar extends StatelessWidget {
  final String? text;
  final bool enabled, ishsow;
  final double height;
  final IconData? iconData;
  final TextEditingController controller;
  final Function(String val) onChange;

  const CommonSearchBar(
      {Key? key,
      this.text,
      this.enabled = false,
      this.height = 40,
      this.iconData,
        required this.controller,
        required this.onChange,
      this.ishsow = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        height: height,
        child: Center(
          child: Row(
            children: <Widget>[
              ishsow == true
                  ? Icon(
                      iconData,
                      // FontAwesomeIcons.search,
                      size: 14,
                      color: Theme.of(context).primaryColor,
                    )
                  : const SizedBox(),
              ishsow == true
                  ? const SizedBox(
                      width: 8,
                    )
                  : const SizedBox(),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  enabled: enabled,
                  controller: controller,
                  onChanged: onChange,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 12),
                    errorText: null,
                    border: InputBorder.none,
                    hintText: text,
                    hintStyle: TextStyles(context)
                        .getDescriptionStyle()
                        .copyWith(
                            color: AppTheme.secondaryTextColor, fontSize: 12),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
