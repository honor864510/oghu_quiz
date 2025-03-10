part of '../quiz_screen.dart';

class _AnswersBox extends StatelessWidget {
  final Widget title;
  final Widget child;

  const _AnswersBox({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth:
            context.width < 1000
                ? 1.0 * context.width * 0.44
                : (1000 / context.width) * context.width * 0.44,
      ),
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
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(
                  AksInternal.constants.borderRadius,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AksInternal.constants.padding * 2,
                  vertical: AksInternal.constants.padding,
                ),
                child: title,
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
