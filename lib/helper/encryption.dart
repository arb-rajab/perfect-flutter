class Encryption {
  static String decryptEncryptionKey(String encryptionKey) {
    List<int> fibonacci = [];
    fibonacci.add(1);
    fibonacci.add(2);
    String password = "";
    if (encryptionKey.isNotEmpty) {
      while (fibonacci[fibonacci.length - 1] < encryptionKey.length - 1) {
        fibonacci.add(
            fibonacci[fibonacci.length - 1] + fibonacci[fibonacci.length - 2]);
      }
      for (int c = 0; c < fibonacci.length; c++) {
        password = "$password${encryptionKey[fibonacci[c]]}";
      }
    }
    return password;
  }
}
