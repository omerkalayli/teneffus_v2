import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/custom_text_button.dart';

@RoutePage()
class MainLayoutPage extends HookConsumerWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(authNotifierProvider.notifier).userInformation;
    var index = useState(1);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(userInfo!.email),
            Text(userInfo.name),
            Text(userInfo.surname),
            Text(userInfo.grade.toString()),
            Text(userInfo.uid),
            CustomTextButton(
                text: "Sign out",
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).signOut();
                }),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: navBarOrange,
                border: Border.all(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(22)),
          ),
          Container(
            height: 180,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: NavBarItem(
                    isSelected: index.value == 0,
                    onTap: () {
                      index.value = 0;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          color: Colors.white,
                          Icons.pest_control_rodent_rounded,
                          size: 40,
                        ),
                        Text(
                          "Oyunlar",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: NavBarItem(
                    isSelected: index.value == 1,
                    onTap: () {
                      index.value = 1;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          color: Colors.white,
                          Icons.home_rounded,
                          size: 40,
                        ),
                        Text(
                          "Ana Menü",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: NavBarItem(
                    isSelected: index.value == 2,
                    onTap: () {
                      index.value = 2;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          color: Colors.white,
                          Icons.menu_book_rounded,
                          size: 40,
                        ),
                        Text(
                          "Kelimeler",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.onTap,
    required this.isSelected,
    required this.child,
    super.key,
  });

  final Widget child;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          curve: !isSelected ? Curves.elasticOut : Curves.linear,
          duration: !isSelected ? Durations.medium2 : Durations.short1,
          bottom: isSelected ? 40 : 16,
          child: InkWell(
            onTap: () {
              onTap.call();
            },
            child: AnimatedContainer(
              duration: Durations.short3,
              width: isSelected ? 116 : 110,
              height: isSelected ? 116 : 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: isSelected
                      ? Border.all(width: 3, color: Colors.white)
                      : null,
                  color: navBarOrange,
                  boxShadow: !isSelected
                      ? []
                      : [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4)
                        ]),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
