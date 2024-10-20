import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hele/core/constants/color_constant.dart';

import '../../../core/constants/image_constant.dart';
import '../../guide/widgets/custom_button.dart';
import '../../guide/widgets/guide_widget.dart';

class DetailOlahTanaman extends StatefulWidget {
  const DetailOlahTanaman({super.key});

  @override
  State<DetailOlahTanaman> createState() => _DetailOlahTanamanState();
}

class _DetailOlahTanamanState extends State<DetailOlahTanaman> {
  final _controller = PageController();
  final _pages = const [
    OnBoardContentWidget(
      title: "Identifikasi & Klasifikasi Sampah B3",
      description:
          "Mengenali jenis sampah B3 & sifat berbahaya, untuk penanganan yang tepat.",
      image: ImageConstant.olahJambuImage1,
    ),
    OnBoardContentWidget(
      title: "Pengumpulan & Transportasi Aman",
      description:
          "Mengumpulkan sampah B3 dengan hati-hati & menghindari risiko kebocoran atau tumpahan.",
      image: ImageConstant.olahJambuImage2,
    ),
    OnBoardContentWidget(
      title: "Penyimpanan Sementara yang Aman",
      description:
          "Menyimpan sementara sampah B3 di tempat yang aman dengan pemisahan yang benar.",
      image: ImageConstant.olahJambuImage3,
    ),
    OnBoardContentWidget(
      title: "Pengolahan & Pemantauan",
      description: "Melakukan sesuai standar keselamatan & lingkungan",
      image: ImageConstant.olahJambuImage4,
    ),
  ];

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        title: const Text(
          "Pengolahan sampah B3 (Bahan Berbahaya dan Beracun)",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 120),
          SizedBox(
            height: 335,
            child: PageView.builder(
              scrollBehavior: const ScrollBehavior(),
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
            ),
          ),
          const SizedBox(height: 74),
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: List<Widget>.generate(
              _pages.length,
              (index) => InkWell(
                onTap: () async {
                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: _activePage == index
                      ? ColorConstant.primaryColor
                      : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 80),
          AnimatedOpacity(
            opacity: _activePage == _pages.length - 1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: CustomButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text("Mengerti"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isLoggedIn() {
    // @TODO: Check if user logged in or not
    return false;
  }
}
