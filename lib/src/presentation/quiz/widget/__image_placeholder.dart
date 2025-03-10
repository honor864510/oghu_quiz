part of '../quiz_screen.dart';

class _ImagePlaceholder extends StatelessWidget {
  final double? radius;

  const _ImagePlaceholder({this.radius});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [5, 10],
      child: SizedBox(
        width: radius ?? context.height * 0.12,
        height: radius ?? context.height * 0.12,

        child: Space.empty,
      ),
    );
  }
}
