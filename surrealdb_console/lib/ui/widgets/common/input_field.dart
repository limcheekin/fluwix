import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surrealdb_console/ui/widgets/common/password_field.dart';

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
          Focus(
            child: Builder(
              builder: (context) {
                if (textInputType == TextInputType.none) {
                  return PasswordField(
                    controller: controller,
                    labelText: labelText,
                    errorText: errorText,
                    hintText: hintText,
                    prefixIcon: prefixIcon,
                  );
                } else {
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
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),

                      //          filled: true,
                      //          fillColor: kcMediumGrey,
                      prefixIcon: prefixIcon,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Focus.of(context).hasFocus &&
                              controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: controller.clear,
                            )
                          : null,
                    ),
                    inputFormatters: inputFormatters,
                    keyboardType: textInputType,
                  );
                }
              },
            ),
          ),
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
