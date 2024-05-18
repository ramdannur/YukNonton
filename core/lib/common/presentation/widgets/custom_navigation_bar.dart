import 'package:core/common/presentation/pages/route_name.dart';
import 'package:flutter/material.dart';

void onSelectedMenu(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushNamed(context, RouteName.movieHomePage);
      break;
    case 1:
      Navigator.pushNamed(context, RouteName.tvHomePage);
      break;
    case 2:
      Navigator.pushNamed(context, RouteName.aboutPage);
      break;
    default:
  }
}

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavigationBar(this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> itemList = ['Movies', 'Series', 'About'];

    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 8.0),
        scrollDirection: Axis.horizontal,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onSelectedMenu(context, index);
            },
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: selectedIndex == index ? const Color(0xFF757575) : Colors.transparent,
                  border: Border.all(width: 1.0, color: selectedIndex == index ? const Color(0xFF757575) : const Color(0xFF515151)),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Text(
                  itemList[index],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8.0);
        },
      ),
    );
  }
}
