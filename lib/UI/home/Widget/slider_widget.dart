import "package:cached_network_image/cached_network_image.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/Services/FireStore/firestore_service.dart";
import "package:grabber_app/Theme/theme.dart";
import "../../../l10n/app_localizations.dart";

class SliderWidget extends StatelessWidget {
  final List<Color> localBackgrounds;
  const SliderWidget({
    super.key,
    this.localBackgrounds = const [
      AppColors.primaryLightColor,
      AppColors.textButtonColor,
      Color(0xFFFFDB24),
    ],
  });


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemsBloc(FirestoreService())..add(const LoadItems("slider")),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (BuildContext context, state) {
            if (state is ItemsLoading) {
              return const Center(child: CircularProgressIndicator());
              // Shimmer(
              //   gradient: LinearGradient(
              //     colors: [
              //       AppColors.primaryLightColor,
              //       AppColors.secondaryLightColor,
              //       AppColors.secondaryDarkColor,
              //     ],
              //     begin: Alignment.centerLeft,
              //     end: Alignment.centerRight,
              //   ),
              //   child: CustomCardWidget(),
              // );
            } else if (state is ItemsLoaded) {
              List<Map> sliderItems = state.items;

              return CarouselSlider.builder(
                itemCount: sliderItems.length,
                itemBuilder: (context, index, realIndex) {
                  final slider = sliderItems[index];
                  final Color bgColor = localBackgrounds[index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: bgColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalizationHelper.getString(
                                    context,
                                    slider["title_en"],
                                  ),
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: slider["isDark"]
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  LocalizationHelper.getString(
                                    context,
                                    slider["subTitle_en"] ?? "",
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: slider["isDark"]
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),

                                const SizedBox(height: 22),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),

                                    color: slider["isDark"]
                                        ? Colors.white
                                        : AppColors.textButtonColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.shopNow,
                                      style: slider["isDark"]
                                          ? Theme.of(
                                              context,
                                            ).textTheme.titleMedium!.copyWith(
                                              color: AppColors.textButtonColor,
                                            )
                                          : Theme.of(
                                              context,
                                            ).textTheme.titleMedium!.copyWith(
                                              color:
                                                  AppColors.primaryLightColor,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            height: 191,
                            width: 117,
                            fit: BoxFit.cover,
                            imageUrl: slider["image_URL"],
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 11),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  autoPlayInterval: const Duration(seconds: 6),
                ),
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
