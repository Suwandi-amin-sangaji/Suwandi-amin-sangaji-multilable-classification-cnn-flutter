import 'package:hele/core/constants/image_constant.dart';

class Article {
  final String title;
  final String subtitle;
  final String image;
  final String sumber;

  const Article({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.sumber,
  });
}

List<Article> informasi = const [
  Article(
    title: 'Cara Mengatasi Hama dan Penyakit Tanaman pada Jagung',
    subtitle: 'corteva',
    image: ImageConstant.articleImage1,
    sumber:
        'https://www.corteva.id/berita/Cara-Mengatasi-Hama-dan-Penyakit-Tanaman-pada-Jagung.html',
  ),
  Article(
    title: 'Penyakit Hawar Daun Kerap Menyapa Tanaman Jagung Dimusim Basah',
    subtitle: 'corteva',
    image: ImageConstant.articleImage2,
    sumber:
        'https://www.corteva.id/berita/Penyakit-Hawar-Daun-Kerap-Menyapa-Tanaman-Jagung-Dimusim-Basah.html',
  ),
  Article(
    title: 'Petunjuk Gejala Kekurangan Hara pada Tanaman Jagung',
    subtitle: 'ayosebar',
    image: ImageConstant.articleImage3,
    sumber:
        'https://ayosebar.com/79-petunjuk-gejala-kekurangan-hara-pada-tanaman-jagung',
  ),
  Article(
    title: 'Bercak Abu-Abu pada Daun Jagung',
    subtitle: 'plantix',
    image: ImageConstant.articleImage4,
    sumber:
        'https://plantix.net/id/library/plant-diseases/100107/grey-leaf-spot-of-maize/',
  ),
  Article(
    title: 'Cara Mengatasi Bulai Pada Tanaman Jagung',
    subtitle: 'kampustani',
    image: ImageConstant.articleImage5,
    sumber:
        'https://www.kampustani.com/cara-mengatasi-bulai-pada-tanaman-jagung/',
  ),
  Article(
    title: 'Kerajinan Dari Botol Plastik Bekas',
    subtitle: 'universaleco',
    image: 'assets/images/artikel6.jpg',
    sumber:
        'https://www.universaleco.id/blog/detail/kerajinan-dari-botol-plastik-bekas/342',
  ),
  Article(
    title: 'Sistem Tanggap Darurat Pengelolaan Limbah B3',
    subtitle: 'universaleco',
    image: 'assets/images/artkel7.jpg',
    sumber:
        'https://www.universaleco.id/blog/detail/sistem-tanggap-darurat-pengelolaan-limbah-b3/324',
  ),
  Article(
    title: 'Prinsip 3R (Reduce, Reuse, dan Recycle) Dalam Pengolahan Sampah',
    subtitle: 'universaleco',
    image: 'assets/images/artkel8.jpg',
    sumber:
        'https://www.universaleco.id/blog/detail/prinsip-3r-reduce-reuse-dan-recycle/156',
  ),
];
