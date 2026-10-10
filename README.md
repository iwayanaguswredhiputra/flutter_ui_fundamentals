# Course Explorer v2

**Nama:** I Wayan Agus Wredhi Putra  
**NIM:** 2415051007  
**Program Studi:** Pendidikan Teknik Informatika  
**Universitas:** Universitas Pendidikan Ganesha  

## Deskripsi Proyek
Proyek aplikasi *Course Explorer v2* dikembangkan dengan menerapkan pola **Clean Architecture** dan manajemen *state* reaktif menggunakan `Provider` untuk memastikan pemisahan tanggung jawab (*separation of concerns*) yang terstruktur dengan baik.

## Struktur Folder & Tanggung Jawab (Clean Architecture)
- `lib/models/`: Berisi cetak biru atau entitas struktur data utama (misal: kelas *Course*).
- `lib/services/`: Bertanggung jawab penuh dalam mengambil data mentah dari sumber luar (misal: memuat dan mendekode data dari *file* JSON di folder *assets*).
- `lib/repositories/`: Berperan sebagai perantara (*bridge*) antara *Service* dan *Provider*, menyaring dan menyediakan data yang siap diolah.
- `lib/providers/`: Mengelola *state* reaktif aplikasi menggunakan `ChangeNotifier` serta memicu pembaruan UI secara otomatis (*reactive UI*).
- `lib/screens/`: Menyimpan kumpulan halaman utama antarmuka pengguna (*User Interface*).
- `lib/widgets/`: Berisi komponen antarmuka modular atau kustom yang dapat digunakan kembali (*reusable widgets*).