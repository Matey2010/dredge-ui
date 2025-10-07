import 'package:dredge_ui/providers.dart';
import 'package:dredge_ui/src/widgets/button.dart';
import 'package:dredge_ui/src/widgets/dr_modal/dr_modal_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrConfirmationModal extends StatelessWidget {
  final String title;
  final bool showCloseButton;
  final EdgeInsets? headerPadding;
  final EdgeInsets? bodyPadding;
  final EdgeInsets? footerPadding;
  final Widget? content;
  final String? description;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final String? cancelButtonText;
  final String? submitButtonText;
  final Widget? cancelButton;
  final Widget? submitButton;
  final BoxDecoration? style;

  const DrConfirmationModal({
    super.key,
    required this.title,
    this.showCloseButton = true,
    this.headerPadding,
    this.bodyPadding,
    this.footerPadding,
    this.content,
    this.description,
    this.onSubmit,
    this.onCancel,
    this.cancelButtonText,
    this.submitButtonText,
    this.cancelButton,
    this.submitButton,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeaderPadding = headerPadding ?? const EdgeInsets.all(16);
    final effectiveBodyPadding = bodyPadding ?? const EdgeInsets.all(16);
    final effectiveFooterPadding = footerPadding ?? const EdgeInsets.all(16);

    return Container(
      decoration:
          style ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DrModalHeader(
            title: title,
            padding: effectiveHeaderPadding,
            onClose: showCloseButton
                ? () {
                    context.read<ModalProvider>().popModal();
                  }
                : null,
          ),
          Padding(
            padding: effectiveBodyPadding,
            child:
                content ??
                (description != null
                    ? Text(description!)
                    : const SizedBox.shrink()),
          ),
          if (onSubmit != null ||
              onCancel != null ||
              submitButton != null ||
              cancelButton != null)
            Padding(
              padding: effectiveFooterPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onCancel != null || cancelButton != null)
                    cancelButton ??
                        DredgeButton(
                          onTap: onCancel,
                          child: Text(cancelButtonText ?? 'Cancel'),
                        ),
                  if ((onSubmit != null || submitButton != null) &&
                      (onCancel != null || cancelButton != null))
                    const SizedBox(width: 8),
                  if (onSubmit != null || submitButton != null)
                    submitButton ??
                        DredgeButton(
                          onTap: onSubmit,
                          child: Text(submitButtonText ?? 'Submit'),
                        ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
