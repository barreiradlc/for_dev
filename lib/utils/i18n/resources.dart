import 'package:flutter/widgets.dart';
import 'package:for_dev/utils/i18n/string/en_us.dart';
import 'package:for_dev/utils/i18n/string/pt_br.dart';
import 'package:for_dev/utils/i18n/string/translations.dart';

class R {
  static Translations strings = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      case 'en_US': strings = EnUs(); break;
      case 'pt_BR': strings = PtBr(); break;
      default: strings = PtBr();
    }
  }
}