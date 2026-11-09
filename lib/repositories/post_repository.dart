import '../models/post.dart';

/// Abstraksi repository untuk mengelola data post.
abstract class PostRepository {
  /// Mengambil daftar semua post.
  Future<List<Post>> getPosts();
}
