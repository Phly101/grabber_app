import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 89,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [LightThemeData.secondaryDarkColor, LightThemeData.secondaryLightColor,LightThemeData.primaryLightColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          )
      ),
      child:  Center(
        child: ListTile(
          leading: ClipOval(
            child: Container(
              color: Colors.white, 
              padding: const EdgeInsets.all(12), 
              width: 50, 
              height: 50,
              child:  const ImageIcon(
                AssetImage("Assets/Icons/Profile.png"),
              ),
            ),
),
          title: const Text("Itunuoluwa Abidoye",
                      style:  TextStyle( 
                          color: LightThemeData.primaryLightColor
                              ),
                    ),
          subtitle: const Text("@Itunuoluwa",
              style: TextStyle(
                color: LightThemeData.primaryLightColor
                ),
                ),
          trailing: MaterialButton(onPressed: () {  },
          child: const ImageIcon(AssetImage("Assets/Icons/Vector.png"))),
        ),
      ),
    )
    ;
  }
}