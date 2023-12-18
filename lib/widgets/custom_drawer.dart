import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  buildDrawerOption(
                    context,
                    'ICD-10',
                    () => {
                      context.goNamed(
                        'home',
                        pathParameters: {
                          'tab': '0',
                        },
                      ),
                    },
                  ),
                  buildDrawerOption(
                    context,
                    'ICD-O',
                    () => {
                      context.goNamed(
                        'home',
                        pathParameters: {
                          'tab': '1',
                        },
                      ),
                    },
                  ),
                  buildDrawerOption(
                    context,
                    'Favorites',
                    () => {
                      context.goNamed(
                        'home',
                        pathParameters: {
                          'tab': '2',
                        },
                      ),
                    },
                  ),
                  buildDrawerOption(
                    context,
                    'Stains',
                    () => {
                      context.goNamed(
                        'home',
                        pathParameters: {
                          'tab': '3',
                        },
                      ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerOption(
      BuildContext context, String text, Function navigateTo,
      [TextStyle? textStyle]) {
    return ListTile(
      title: Text(
        text,
        style: textStyle ??
            const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.grey),
      ),
      onTap: () {
        Navigator.pop(context);
        navigateTo();
      },
    );
  }
}
