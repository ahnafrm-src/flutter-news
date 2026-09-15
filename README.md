# 📰 FlutterNews

Aplikasi berita berbasis Flutter yang mengambil data secara real-time dari [NewsAPI](https://newsapi.org). Pengguna dapat membaca berita terkini, memfilter berdasarkan kategori, dan mencari berita berdasarkan kata kunci.

---

## ✨ Fitur

- 📋 **Daftar Berita** — Menampilkan berita terbaru dari Indonesia secara real-time
- 🗂️ **Filter Kategori** — Pilih berita berdasarkan kategori: Semua, Teknologi, Internasional, Ekonomi, Olahraga, Hiburan, Gaya Hidup
- 🔍 **Pencarian Berita** — Cari berita berdasarkan kata kunci
- 📄 **Detail Berita** — Tampilan detail lengkap beserta gambar, penulis, dan tanggal
- 🔗 **Buka Artikel Asli** — Buka artikel lengkap di browser eksternal
- 🔄 **Pull to Refresh** — Perbarui daftar berita dengan gestur tarik ke bawah

---

## 🛠️ Teknologi

| Teknologi | Keterangan |
|---|---|
| Flutter | Framework UI cross-platform |
| Dart | Bahasa pemrograman |
| NewsAPI | Sumber data berita |
| `http` | HTTP request ke API |
| `url_launcher` | Membuka URL di browser eksternal |

---

## 📁 Struktur Project

```
lib/
├── models/
│   ├── api.dart       # Konfigurasi URL endpoint NewsAPI
│   └── news.dart      # Model data: News, Article, Source
├── screens/
│   ├── home.dart      # Halaman utama: list berita, kategori, search
│   └── detail.dart    # Halaman detail berita
└── main.dart
```

---

## 🚀 Cara Menjalankan

### 1. Clone Repository

```bash
git clone https://github.com/username/flutter-news.git
cd flutter-news
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Konfigurasi API Key

Buka file `lib/models/api.dart` (atau bagian `BaseUrl` di `home.dart`), lalu ganti API key dengan milikmu:

```dart
static const String apiKey = "ISI_API_KEY_KAMU_DI_SINI";
```

> Daftar API key gratis di [https://newsapi.org/register](https://newsapi.org/register)

### 4. Jalankan Aplikasi

```bash
flutter run
```

---

## 📡 Endpoint API

| Kategori | Endpoint |
|---|---|
| Semua (Indonesia) | `/v2/everything?q=indonesia` |
| Teknologi | `/v2/top-headlines?category=technology` |
| Internasional | `/v2/top-headlines?category=general` |
| Ekonomi | `/v2/top-headlines?category=business` |
| Olahraga | `/v2/top-headlines?category=sports` |
| Hiburan | `/v2/top-headlines?category=entertainment` |
| Gaya Hidup | `/v2/top-headlines?category=health` |
| Search | `/v2/everything?q={query}` |

---

## ⚠️ Catatan

- API key yang tersedia di repository ini bersifat **demo** dan dapat dibatasi sewaktu-waktu. Disarankan menggunakan API key sendiri.
- NewsAPI pada plan gratis hanya mendukung **developer mode** — untuk production perlu upgrade plan.

---

## 👨‍💻 Developer

**Ahnaf Raihan Muafa**  
SMK RPL — Malang, Jawa Timur  
[GitHub](https://github.com/ahnafrm-src)
