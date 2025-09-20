import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";

class SliderWidget extends StatelessWidget {
  final Map<String, dynamic> slide;

  const SliderWidget({
    super.key,
    required this.slide,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: slide["backgroundColor"],
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slide["text"] ?? "",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: slide["isDark"]
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    slide["subText"] ?? "",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: slide["isDark"]
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 11),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: slide["isDark"]
                          ? Colors.white
                          : AppColors.textButtonColor,
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Shop Now",
                      style: slide["isDark"]
                          ? Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.textButtonColor,
                            )
                          : Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.primaryLightColor,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Image.asset(
                slide["image"],
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
