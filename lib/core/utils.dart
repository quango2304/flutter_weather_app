import 'package:intl/intl.dart';

class Utils {
  static String makeNewLineEveryWord(String inputText) {
    // Split the text into words
    List<String> words = inputText.split(' ');

    // Add a new line after each word
    String result = words.join('\n');

    return result;
  }

  static DateTime parseDateTime(String time) {
    //yyyy-MM-dd H:mm
    if (time.length == 15) {
      DateFormat format = DateFormat('yyyy-MM-dd H:mm');
      DateTime parsedDateTime = format.parse(time);
      return parsedDateTime;
    }
    return DateTime.parse(time);
  }
}
