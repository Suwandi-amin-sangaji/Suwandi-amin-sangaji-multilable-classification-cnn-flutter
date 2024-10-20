class PlantModel {
  int? id;
  String? nama;
  String? jenis;
  String? gambar;
  String? deskripsi;

  PlantModel({this.id, this.nama, this.jenis, this.gambar, this.deskripsi});

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    jenis = json['jenis'];
    gambar = json['gambar'];
    deskripsi = json['deskripsi'];
  }
}
