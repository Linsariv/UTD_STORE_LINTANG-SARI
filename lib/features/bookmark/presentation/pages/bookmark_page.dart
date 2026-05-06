import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../data/datasources/bookmark_local_datasource.dart';
import '../../data/models/bookmark_model.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<BookmarkModel> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final data = await sl<BookmarkLocalDataSource>().getBookmarks();
    setState(() {
      bookmarks = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmark")),
      body: bookmarks.isEmpty
          ? const Center(child: Text("Belum ada bookmark"))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final b = bookmarks[index];
                return ListTile(
                  title: Text(b.title),
                  subtitle: Text("Rp ${b.price}"),
                );
              },
            ),
    );
  }
}