import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shimmer/shimmer.dart";
import "../../../../Blocs/Theming/app_theme_bloc.dart";
import "../../../../LocalizationHelper/localization_helper.dart";
import "../../../../Services/FireStore/bloc/items_bloc.dart";
import "../../../../Services/FireStore/firestore_service.dart";
import "../../../../Theme/theme.dart";
import "../../../../common/custom_card_widget.dart";

class HomeCategory extends StatelessWidget {
  final void Function(String category) onCategoryTap;

  const HomeCategory({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeBloc = context.read<AppThemeBloc>();

    return BlocProvider(
      create: (context) =>
          ItemsBloc(FirestoreService())..add(const LoadItems("category")),
      child: SizedBox(
        height: 130,
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoading) {
              return const Shimmer(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryLightColor,
                    AppColors.secondaryLightColor,
                    AppColors.secondaryDarkColor,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                child: CustomCardWidget(),
              );
            } else if (state is ItemsLoaded) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> category = state.items[index];
                  final String title = LocalizationHelper.localizedProductField(
                    category,
                    "title",
                    context,
                  );
                  final String key = category["category"]?? "";
                  final String imageUrl = category["image_URL"] ?? "";
                  return InkWell(
                    onTap: () => onCategoryTap(key),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 11,
                      ),
                      child: Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                          const SizedBox(height: 11),
                          Text(
                            LocalizationHelper.getString(context, title) ?? "",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: themeBloc.state.appTheme == "L"
                                  ? AppColors.textButtonColor
                                  : AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ItemsError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
