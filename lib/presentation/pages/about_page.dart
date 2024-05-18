import 'package:core/common/constants.dart';
import 'package:core/common/presentation/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/circle-g.png',
          ),
        ),
        title: const CustomNavigationBar(2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(60.0),
              color: kPrussianBlue,
              child: Center(
                child: Image.asset(
                  'assets/circle-g.png',
                  width: 128,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'YukNonton! adalah aplikasi yang dirancang untuk penggemar film dan TV series, menyediakan katalog lengkap yang mencakup berbagai genre dan negara asal. Aplikasi ini memungkinkan pengguna untuk menemukan informasi terperinci tentang film dan TV series favorit mereka, termasuk sinopsis, rating, ulasan, dan lainnya.',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
