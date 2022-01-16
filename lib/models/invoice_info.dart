class InvoiceInfo {
  static String logoUnitel =
      "https://play-lh.googleusercontent.com/EXT04dzrRZ0fGyAjyy-MQ3_9snTY226gZOm_JwhOxCjpX0OvBJD9AT4CnezCAwp18U3J";
  static String logoTruemoney =
      "https://ifranchise.ph/wp-content/uploads/2019/03/truemoney-franchise-512x303.png";
  static String logoLaotel = "https://pbs.twimg.com/media/ErBX5jNVkAA5lUg.jpg";
  static String logoETL =
      "https://internetlaos.com/wp-content/uploads/2012/05/etl_logo.png";
  static String logoBeeline =
      "https://img.favpng.com/24/17/1/beeline-ojsc-vimpelcom-kaspiytelekom-mts-logo-png-favpng-RJY1Ptz7TuM1Z4thMEmvMNQRQ.jpg";
  static String headerUnitel = "Unitel";
  static String headerTruemoney = "True Money";
  static String headerLaotel = "Lao telecom";
  static String headerETL = "ETL";
  static String headerBeeline = "Beeline";
  static String header(String code) {
    String hd = "";
    if (code == "1000") {
      hd = headerTruemoney;
    } else if (code == "1003") {
      hd = headerLaotel;
    } else if (code == "1004") {
      hd = headerUnitel;
    } else if (code == "1005") {
      hd = headerETL;
    } else if (code == "1006") {
      hd = headerBeeline;
    } else {
      hd = "Unknow";
    }
    return hd;
  }

  static String logoStr(String code) {
    String lg = "";
    if (code == "1000") {
      lg = logoTruemoney;
    } else if (code == "1003") {
      lg = logoLaotel;
    } else if (code == "1004") {
      lg = logoUnitel;
    } else if (code == "1005") {
      lg = logoETL;
    } else if (code == "1006") {
      lg = logoBeeline;
    } else {
      lg = "Unknow";
    }
    return lg;
  }
}
