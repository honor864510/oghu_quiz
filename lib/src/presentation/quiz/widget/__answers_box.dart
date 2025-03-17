part of '../quiz_screen.dart';

class _AnswersBox extends StatelessWidget {
  final Widget title;
  final Widget child;

  const _AnswersBox({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.width * 0.3),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AksInternal.constants.borderRadius,
          ),
          border: Border.all(color: context.colorScheme.primary),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AksInternal.constants.padding,
          children: [
            Align(
              alignment: Alignment.center,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    AksInternal.constants.borderRadius,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: context.height * 0.12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.height * 0.03,
                      ),
                      child: title,
                    ),
                  ),
                ),
              ),
            ),
            child,
            Space.v10,
          ],
        ),
      ),
    );
  }
}
