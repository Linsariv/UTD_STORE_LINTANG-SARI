class SplashService {
  Future<void> startDelay() async {
    int lastDigit = 2; // dari NIM kamu

    await Future.delayed(Duration(seconds: lastDigit));
  }
}