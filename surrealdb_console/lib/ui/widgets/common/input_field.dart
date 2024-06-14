import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.controller,
    super.key,
    this.labelText,
    this.errorText,
    this.hintText = '',
    this.inputFormatters,
    this.textInputType,
    this.prefixIcon,
  });
  final TextEditingController controller;
  final String? labelText;
  final String? errorText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Widget? prefixIcon;

  static const double kdDesktopMaxContentWidth = 1150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*SizedBox(
            width: getValueForScreenType<double>(
              context: context,
              mobile: double.infinity,
              tablet: kdDesktopMaxContentWidth * 0.3,
              desktop: kdDesktopMaxContentWidth * 0.3,
            ),
            child:*/
          Focus(
            child: Builder(
              builder: (context) {
                return TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    label: labelText != null
                        ? Text(
                            labelText!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : null,
                    //alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),

                    //          filled: true,
                    //          fillColor: kcMediumGrey,
                    prefixIcon: prefixIcon,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon:
                        Focus.of(context).hasFocus && controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: controller.clear,
                              )
                            : null,
                  ),
                  obscureText: textInputType == TextInputType.none,
                  obscuringCharacter: '*',
                  inputFormatters: inputFormatters,
                  keyboardType: textInputType,
                );
              },
            ),
          ),
          //),
          if (errorText != null) ...[
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                errorText!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
