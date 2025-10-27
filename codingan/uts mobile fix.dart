import 'dart:math';

// === Abstract Class (Abstraksi) ===
abstract class Transportasi {
  String id, nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;

  double hitungTarif(int penumpang);
  void info() =>
      print("[$nama] ID:$id | Tarif Dasar: Rp$_tarifDasar | Kapasitas: $kapasitas");
}

// === Subclass Ojek ===
class Ojek extends Transportasi {
  double jarak; // dalam km
  Ojek(super.id, super.nama, super._tarifDasar, super.kapasitas, this.jarak);

  @override
  double hitungTarif(int penumpang) => tarifDasar * jarak + 3000;
}

// === Subclass Kereta ===
class Kereta extends Transportasi {
  bool eksekutif;
  Kereta(super.id, super.nama, super._tarifDasar, super.kapasitas, this.eksekutif);

  @override
  double hitungTarif(int penumpang) =>
      (tarifDasar * penumpang) + (eksekutif ? 25000 : 0);
}

// === Subclass Kapal ===
class Kapal extends Transportasi {
  String rute;
  Kapal(super.id, super.nama, super._tarifDasar, super.kapasitas, this.rute);

  @override
  double hitungTarif(int penumpang) {
    double faktor = rute == "Antarpulau" ? 1.5 : 1.0;
    return tarifDasar * penumpang * faktor;
  }
}

// === Class Pemesanan ===
class Pemesanan {
  String kode, namaPemesan;
  Transportasi trans;
  int jumlah;
  double total;

  Pemesanan(this.kode, this.namaPemesan, this.trans, this.jumlah, this.total);

  void cetak() => print(
      "\n$kode | $namaPemesan memesan ${trans.nama} untuk $jumlah orang. Total Bayar: Rp${total.toStringAsFixed(0)}");
}

// === Fungsi Membuat Pemesanan ===
Pemesanan buatPemesanan(Transportasi t, String nama, int jumlah) {
  String kode = "TRX${Random().nextInt(9000) + 1000}";
  double total = t.hitungTarif(jumlah);
  return Pemesanan(kode, nama, t, jumlah, total);
}

// === Fungsi Menampilkan Semua Pemesanan ===
void tampilkan(List<Pemesanan> daftar) {
  print("\n=== Daftar Pemesanan Transportasi ===");
  for (var p in daftar) {
    p.cetak();
  }
}

// === Fungsi Utama ===
void main() {
  var ojek = Ojek("OJ01", "Ojek Cepat", 2500, 1, 8.5);
  var kereta = Kereta("KR01", "Kereta Cepat", 50000, 200, true);
  var kapal = Kapal("KP01", "Kapal Cepat", 120000, 300, "Antarpulau");

  var daftar = [
    buatPemesanan(ojek, "Fawwaz", 1),
    buatPemesanan(kereta, "Messi", 3),
    buatPemesanan(kapal, "Augusta", 2),
  ];

  tampilkan(daftar);
}
