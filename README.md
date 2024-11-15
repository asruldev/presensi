### Penjelasan Struktur Folder

assets/:

Tempat untuk menyimpan file yang digunakan di seluruh aplikasi seperti gambar, font, dll.
components/:

Folder ini menyimpan widget yang bersifat reusable. Misalnya, jika kamu membuat tombol atau card yang digunakan di banyak tempat dalam aplikasi, simpan di sini.
models/:

Tempat untuk menyimpan model data yang digunakan dalam aplikasi. Misalnya, model Absensi, User, dll.
screens/:

Setiap halaman aplikasi sebaiknya memiliki folder atau file terpisah di sini. Misalnya, dashboard.dart, attendance_screen.dart, dll.
services/:

Tempat untuk menyimpan file yang menghubungkan aplikasi dengan layanan eksternal seperti API. Contoh file di sini termasuk api_service.dart, auth_service.dart, dll.
utils/:

Tempat untuk fungsi-fungsi kecil yang digunakan di seluruh aplikasi, seperti format tanggal, validasi input, dll.
providers/:

Jika menggunakan state management (misalnya Provider atau Riverpod), kamu bisa menyimpan file di sini.
theme/:

Untuk pengaturan tema dan styling global aplikasi seperti palet warna, font, dll.
localizations/:

Jika aplikasi mendukung berbagai bahasa, kamu bisa menaruh file lokal di sini.