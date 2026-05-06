import 'package:isar/isar.dart';
import '../models/bookmark_model.dart';

class BookmarkLocalDataSource {
  final Isar isar;

  BookmarkLocalDataSource(this.isar);

  Future<void> addBookmark(BookmarkModel bookmark) async {
    await isar.writeTxn(() async {
      await isar.bookmarkModels.put(bookmark);
    });
  }

  Future<List<BookmarkModel>> getBookmarks() async {
   return await isar.bookmarkModels.where().findAll();
  }

  Stream<List<BookmarkModel>> watchBookmarks() {
    return isar.bookmarkModels.where().watch(fireImmediately: true);
  }
}