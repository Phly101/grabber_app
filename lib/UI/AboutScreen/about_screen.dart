import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/Utils/routes.dart";

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final blocTheme = context.read<AppThemeBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context, AppRoutes.profile);
        }, icon: Icon(Icons.arrow_back_ios,color: theme.colorScheme.onPrimary,)),
        title: Text("About Grabber",style: theme.textTheme.titleLarge!.copyWith(
          color:  AppColors.white
        ),),

        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.green[600],
                  child: Image.asset("Assets/Images/Logo 1@3x.png"),
                ),
                const SizedBox(height: 12),
                Text(
                  "Gragger",
                  style: theme.textTheme.titleLarge!.copyWith(
                      color: blocTheme.state.appTheme == "L"? AppColors.textButtonColor : AppColors.white)
                ),
                 const SizedBox(height: 10,),
                 Text(
                  "Version 1.0.0",
                  style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.grey)
                ),
              ],
            ),
            const SizedBox(height: 20),


            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Grabber is your smart shopping list companion. "
                      "Easily add groceries, track quantities, and stay organized. "
                      "Whether at home or in the store, Gragger keeps your shopping hassle-free.",
                  style: theme.textTheme.bodyLarge!.copyWith(
                      color: blocTheme.state.appTheme == "L"? AppColors.textButtonColor : AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),


            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child:  const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.green),
                    title: Text("Developed by"),
                    subtitle: Text("MSB"),
                  ),
                  Divider(height: 0,color: AppColors.white,),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: Icon(Icons.email, color: Colors.green),
                      title: Text("Email"),
                      subtitle: Text("basel.10@gmail.com"),
                    ),
                  ),
                  Divider(height: 0,color:AppColors.white,),
                  ListTile(
                    leading: Icon(Icons.public, color: Colors.green),
                    title: Text("Website"),
                    subtitle: Text("www.grabber.com"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),


            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.article_outlined, color: Colors.white),
              label:  Text("View Open Source Licenses", style: theme.textTheme.bodyLarge!.copyWith(
                  color: AppColors.white)),
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: "Grabber",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Gragger. All rights reserved.",
                );
              },
            ),
            const SizedBox(height: 30),


            Text(
              "© 2025 Gragger. All rights reserved.",
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
