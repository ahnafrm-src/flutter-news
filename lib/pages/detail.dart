import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import '../models/news.dart';

class Detail extends StatelessWidget {
  final Article sw;

  const Detail({Key? key, required this.sw}) : super(key: key);

  Future<void> _launchUrl(String urlString) async {
    if (urlString.isEmpty) return;

    final Uri url = Uri.parse(urlString);

    try {
      if (kIsWeb) {
        // Khusus Running di Browser / Web
        await launchUrl(
          url,
          webOnlyWindowName: '_blank', // Buka di tab baru
        );
      } else {
        // Khusus Running di HP / Emulator (Android/iOS)
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama
            if (sw.urlToImage != null && sw.urlToImage!.isNotEmpty)
              Image.network(
                sw.urlToImage!,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
              )
            else
              _buildPlaceholderImage(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sumber / Publisher
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      sw.source.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Judul Berita
                  Text(
                    sw.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Penulis & Tanggal
                  Text(
                    '${sw.author != null && sw.author!.isNotEmpty ? "${sw.author} • " : ""}${_formatDate(sw.publishedAt)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),

                  const Divider(height: 24),

                  // Deskripsi / Ringkasan
                  if (sw.description.isNotEmpty) ...[
                    Text(
                      sw.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Konten Singkat dari NewsAPI
                  if (sw.content.isNotEmpty)
                    Text(
                      sw.content,
                      style: const TextStyle(fontSize: 15, height: 1.7),
                    )
                  else
                    const Text(
                      'Konten lengkap tidak tersedia secara langsung.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 220,
      width: double.infinity,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
