import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('isValidEmail', () {
    test('email valid mengembalikan true', () {
      expect(Validators.isValidEmail('nana@gmail.com'), isTrue);
      expect(Validators.isValidEmail('user.name@mail.co.id'), isTrue);
    });

    test('email tanpa @ mengembalikan false', () {
      expect(Validators.isValidEmail('nanagmail.com'), isFalse);
    });

    test('email tanpa domain/titik mengembalikan false', () {
      expect(Validators.isValidEmail('nana@gmail'), isFalse);
    });

    test('email tanpa nama pengguna mengembalikan false', () {
      expect(Validators.isValidEmail('@gmail.com'), isFalse);
    });

    test('string kosong mengembalikan false', () {
      expect(Validators.isValidEmail(''), isFalse);
    });
  });

  group('sanitize', () {
    test('mengganti tag HTML berbahaya', () {
      expect(
        Validators.sanitize('<script>alert("x")</script>'),
        '&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt;',
      );
    });

    test('mengganti tanda petik tunggal', () {
      expect(Validators.sanitize("it's"), 'it&#39;s');
    });

    test('menghapus spasi di awal dan akhir', () {
      expect(Validators.sanitize('  halo  '), 'halo');
    });

    test('input aman tidak berubah', () {
      expect(Validators.sanitize('Halo dunia'), 'Halo dunia');
    });
  });

  group('validateText', () {
    test('null atau kosong mengembalikan pesan error', () {
      expect(Validators.validateText(null), 'Field tidak boleh kosong');
      expect(Validators.validateText('   '), 'Field tidak boleh kosong');
    });

    test('teks dengan panjang valid mengembalikan null', () {
      expect(Validators.validateText('Nana'), isNull);
    });

    test('teks tepat 100 karakter masih valid', () {
      expect(Validators.validateText('a' * 100), isNull);
    });

    test('teks 101 karakter ditolak', () {
      expect(
        Validators.validateText('a' * 101),
        'Field harus antara 1-100 karakter',
      );
    });

    test('teks lebih pendek dari minLength ditolak', () {
      expect(
        Validators.validateText('ab', minLength: 3),
        'Field harus antara 3-100 karakter',
      );
    });

    test('fieldName kustom dipakai di pesan error', () {
      expect(
        Validators.validateText('', fieldName: 'Nama'),
        'Nama tidak boleh kosong',
      );
    });
  });
}
