import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/toolbar.dart';
import 'package:flutter_application_auth/provider/auth.provider.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final test = Provider.of<AuthProvider>(context).accessToken;
    return Scaffold(
        appBar: Toolbar(title: 'Home Page'),
        body: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width),
          decoration: BoxDecoration(color: AppColors.backgroundApp),
          child: Column(
            children: [Text('Home!$test')],
          ),
        ));
  }
}
