

import 'package:ecommerce_flutter/models/users/user_model.dart';
import 'package:ecommerce_flutter/providers/theme_provider.dart';
import 'package:ecommerce_flutter/providers/user_provider.dart';
import 'package:ecommerce_flutter/screens/auth/login_screen.dart';
import 'package:ecommerce_flutter/screens/init_screen/favorites_screen.dart';
import 'package:ecommerce_flutter/screens/init_screen/viewed_recently_screen.dart';
import 'package:ecommerce_flutter/services/MyAppFunctions.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/loading_manager_widget.dart';
import 'package:ecommerce_flutter/widgets/orders/order_screen.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin{

  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool isLoading = true;

  Future<void> fetchUserInfo() async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try{
      setState(() {
        isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    }catch(e){
      await MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: e.toString(), fct: (){});
    }
    finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      //APP BAR ------------ //
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
                AssetsManager.card
            ),
          ),
        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: LoadingManagerWidget(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: user == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: user == null ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            //Kullnici giris uyarisi
            Visibility(
              visible: user == null ? true : false,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TitleTextWidget(label: "Please login to have unlimited access."),
              ),
            ),
            userModel == null
            ? const SizedBox.shrink()
            : Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 3
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            userModel!.userImage,
                          ),
                          fit: BoxFit.fill
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(userModel!.userImage.isNotEmpty ? userModel!.userImage : AssetsManager.user512),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextWidget(label: userModel!.userName,),
                        const SizedBox(height: 3,),
                        SubTitleTextWidget(label: "E-Mail: ${userModel!.userEmail}")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 3,),
            userModel == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.only(left: 7.0,right: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitleTextWidget(label: "Information"),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomListTile(
                      imagePath: AssetsManager.basket,
                      text: "All Orders",
                      function: (){
                        Navigator.pushNamed(context, OrderScreen.routeName);
                      }),
                  CustomListTile(
                      imagePath: AssetsManager.heart,
                      text: "Favorites",
                      function: (){
                        Navigator.pushNamed(context, FavoritesScreen.routeName);
                      }),
                  CustomListTile(
                      imagePath: AssetsManager.clock,
                      text: "Viewed Recently",
                      function: (){
                        Navigator.pushNamed(context, ViewedRecentlyScreen.routeName);
                      }),
                  CustomListTile(
                      imagePath: AssetsManager.location,
                      text: "Address",
                      function: (){

                      }),
                  const Divider(
                    thickness: 1,
                  ),
                  CustomListTile(
                      imagePath: AssetsManager.privacy,
                      text: "Settings",
                      function: (){

                      }),
                  SwitchListTile(
                    title: Text(
                        themeProvider.getIsDarkTheme ? "Dark Mode" : "Light Mode"
                    ),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async{
                  if(user == null){
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }
                  else{
                    await MyAppFunctions.showErrorOrWarningDialog(
                        context : context,
                        subtitle : "Are you sure ?",
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if(!mounted){
                            return;
                          }
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                        isError:false
                    );
                  }
                },
                icon: Icon(user == null ?  Icons.login : Icons.logout),
                label: Text(user == null ? "Login" : "Logout"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath,text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubTitleTextWidget(label: text,),
      leading: Container(
        height: 34,
        width: 34,
        child: ClipOval(
            child: Image.asset(imagePath,)
        ),
      ),
      trailing: const Icon(Icons.arrow_right),
    );
  }
}

