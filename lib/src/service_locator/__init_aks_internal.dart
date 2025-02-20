part of 'sl.dart';

const _verticalSeparator = Space.v10;
const _horizontalSeparator = Space.h10;
const _borderRadius = 12.0;
const _padding = 12.0;
const _animationDuration = Duration(milliseconds: 400);

void _initAksInternal() {
  final appConstants = AksAppConstants(
    verticalSeparator: _verticalSeparator,
    horizontalSeparator: _horizontalSeparator,
    borderRadius: _borderRadius,
    padding: _padding,
    animationDuration: _animationDuration,
  );

  final aksDefaultBuilders = AksDefaultBuilders(
    horizontalSeparatorBuilder: (_, __) => _horizontalSeparator,
    verticalSeparatorBuilder: (_, __) => _verticalSeparator,
    errorImageBuilder:
        (context) =>
            Assets.icons.oghuLogo.image(color: context.colorScheme.primary),
  );

  final aksConfig = AksAppConfig(
    appConstants: appConstants,
    aksDefaultBuilders: aksDefaultBuilders,
  );

  AksInternal(aksConfig: aksConfig);
}
