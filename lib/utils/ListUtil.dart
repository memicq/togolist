class ListUtil {
  static Iterable<T> insertWithStride<T>(Iterable<T> baseList, Iterable<T> insertList, int stride) sync* {
    final itb = baseList.iterator;
    final iti = insertList.iterator;

    var counter = 0;
    while (itb.moveNext()) {
      yield itb.current;
      counter += 1;
      if (counter == 10) {
        if (iti.moveNext()) yield iti.current;
        counter = 0;
      }
    }
  }

  static Iterable<T> zip<T>(Iterable<T> a, Iterable<T> b) sync* {
    final ita = a.iterator;
    final itb = b.iterator;
    bool hasa, hasb;
    while ((hasa = ita.moveNext()) | (hasb = itb.moveNext())) {
      if (hasa) yield ita.current;
      if (hasb) yield itb.current;
    }
  }
}