import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/api.dart';
import '../models/news.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Article>> berita;
  final searchController = TextEditingController();
  String _activeCategory = 'Semua';

  final List<Map<String, String>> _categories = [
    {'label': 'Semua', 'url': BaseUrl.semua},
    {'label': 'Teknologi', 'url': BaseUrl.technology},
    {'label': 'Internasional', 'url': BaseUrl.internasional},
    {'label': 'Ekonomi', 'url': BaseUrl.ekonomi},
    {'label': 'Olahraga', 'url': BaseUrl.olahraga},
    {'label': 'Hiburan', 'url': BaseUrl.hiburan},
    {'label': 'Gaya Hidup', 'url': BaseUrl.gayaHidup},
  ];

  @override
  void initState() {
    super.initState();
    berita = getBerita(BaseUrl.semua);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<List<Article>> getBerita(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['status'] == 'ok' && body['articles'] != null) {
          final items = body['articles'] as List;
          return items.map((e) => Article.fromJson(e)).toList();
        }
      } else {
        debugPrint('Fetch Error [${response.statusCode}]: ${response.body}');
      }
      return [];
    } catch (e) {
      debugPrint('Exception in getBerita: $e');
      return [];
    }
  }

  Future<List<Article>> searchBerita(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return [];

    try {
      // Encode query agar karakter khusus/spasi tidak merusak format URL
      final encodedQuery = Uri.encodeComponent(cleanQuery);
      final url = '${BaseUrl.searchBase}&q=$encodedQuery&sortBy=publishedAt';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['status'] == 'ok' && body['articles'] != null) {
          final items = body['articles'] as List;
          return items.map((e) => Article.fromJson(e)).toList();
        }
      } else {
        debugPrint('Search Error [${response.statusCode}]: ${response.body}');
      }
      return [];
    } catch (e) {
      debugPrint('Exception in searchBerita: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari berita...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            _activeCategory = 'Semua';
                            berita = getBerita(BaseUrl.semua);
                          });
                        },
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (val) {
                // Memunculkan/menyembunyikan tombol 'X' (clear text) secara dinamis
                setState(() {});
              },
              onSubmitted: (query) {
                if (query.trim().isNotEmpty) {
                  setState(() {
                    _activeCategory = '';
                    berita = searchBerita(query);
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final cat = _categories[i];
                final isActive = _activeCategory == cat['label'];
                return ChoiceChip(
                  label: Text(cat['label']!),
                  selected: isActive,
                  onSelected: (_) {
                    searchController.clear();
                    setState(() {
                      _activeCategory = cat['label']!;
                      berita = getBerita(cat['url']!);
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Article>>(
              future: berita,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada berita ditemukan'),
                  );
                }
                final data = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _activeCategory = 'Semua';
                      searchController.clear();
                      berita = getBerita(BaseUrl.semua);
                    });
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                item.urlToImage != null &&
                                    item.urlToImage!.isNotEmpty
                                ? Image.network(
                                    item.urlToImage!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _buildPlaceholderImage(),
                                  )
                                : _buildPlaceholderImage(),
                          ),
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${item.source.name} • ${_formatDate(item.publishedAt)}',
                            style: const TextStyle(fontSize: 11),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Detail(sw: item),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
