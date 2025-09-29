import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../Blocs/Theming/app_theme_bloc.dart";
import "../../../../LocalizationHelper/localization_helper.dart";
import "../../../../Services/FireStore/bloc/items_bloc.dart";
import "../../../../Services/FireStore/firestore_service.dart";
import "../../../../Theme/theme.dart";

class HomeCategory extends StatefulWidget {
  final void Function(String category) onCategoryTap;

  const HomeCategory({super.key, required this.onCategoryTap});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeBloc = context.read<AppThemeBloc>();

    return BlocProvider(
      create: (context) =>
          ItemsBloc(FirestoreService())..add(const LoadItems("category")),
      child: SizedBox(
        height: 180,
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoading) {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is ItemsLoaded) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final category = state.items[index];
                  final text = category["title_en"] ?? "";
                  final imageUrl = category["image_URL"] ?? "";

                  return InkWell(
                    onTap: () => widget.onCategoryTap(text),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 11,
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 11),
                          Text(
                            LocalizationHelper.getString(context, text),
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
