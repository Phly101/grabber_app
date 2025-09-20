import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../Blocs/Theming/app_theme_bloc.dart";
import "../Theme/theme.dart";

class GradientWidgetContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final BoxShadow? boxShadow;
  final LinearGradient? gradient; // optional override gradient
  final Color? solidColor; // optional override solid color
  final bool? enableGradient;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end; // if false => force solid
  final BoxDecoration? decoration;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const GradientWidgetContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.boxShadow,
    this.gradient,
    this.solidColor,
    this.enableGradient,
    this.decoration,
    this.begin,
    this.end, this.padding, this.borderRadiusGeometry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeBloc, AppThemeState>(
      builder: (context, state) {
        // default theme-based gradient
        final defaultGradient = (state.appTheme == "L")
            ?  LinearGradient(
                colors: [
                  AppColors.primaryLightColor,
                  AppColors.secondaryLightColor,
                  AppColors.secondaryDarkColor,
                ],
                begin: begin ?? Alignment.centerLeft,
                end: end ?? Alignment.centerRight,
              )
            :  LinearGradient(
                colors: [
                  AppColors.mediumGrey,
                  AppColors.darkGrey,
                  AppColors.darkBackground,
                ],
                begin: begin ?? Alignment.centerLeft,
                end: end ?? Alignment.centerRight,
              );

        // default theme-based solid color
        final defaultSolid = (state.appTheme == "L")
            ? Colors.white
            : AppColors.darkSurface;
        final bool allowGradient = enableGradient ?? true;
        return Container(
          width: width,
          height: height,
          padding: padding,
          decoration:
              decoration ??
              BoxDecoration(
                borderRadius: borderRadiusGeometry?? BorderRadius.circular(10),
                gradient: allowGradient ? (gradient ?? defaultGradient) : null,
                color: allowGradient ? null : (solidColor ?? defaultSolid),
                boxShadow: [
                  boxShadow ??
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                ],
              ),
          child: child,
        );
      },
    );
  }
}
