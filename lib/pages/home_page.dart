import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_button.dart';
import 'package:flutter_application_auth/components/toolbar.dart';
import 'package:flutter_application_auth/provider/auth.provider.dart';
import 'package:flutter_application_auth/provider/user.provider.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';
import 'package:flutter_application_auth/styles/app_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provder = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getCurrentUserCall(provder.accessToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(title: 'Home Page', actions: [
          Consumer<AuthProvider>(builder: (context, auth, child) {
            return PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {
                            auth.logout(context);
                          },
                          child: const Row(
                            children: [
                              Text('Logout'),
                              Spacer(),
                              Icon(
                                Icons.logout_outlined,
                                color: AppColors.primary,
                              )
                            ],
                          ))
                    ]);
          })
        ]),
        body: Consumer2<UserProvider, AuthProvider>(
            builder: (context, user, auth, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcom: ${user.user!.firstName} ${user.user!.lastName}',
                    style: AppText.paragraph1),
                Spacer(),
                CustomButton(
                    text: 'Logout!',
                    onPressed: () {
                      auth.logout(context);
                    })
              ],
            )),
          );
        }));
  }
}
