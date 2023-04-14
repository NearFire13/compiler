int compute(int a, int d) {
    int b, c = a + d * 5;
    b = a;
    while (c > 0) {
      b = b + a * 4;
    }
    return b;
}

void main(void) {
  int a;
  if (a == 3) {
    print(a);
  } else {
    int b = compute(a, 2 * a);
    print(b);
  }

  const int c = 5;
  const int d;
  const int e = 6, f = 8;
  const int g, h = 8;
  const int i = 8, j;
  const int k = 8, l, m;
  const int n = 8, o, p = 5;
  const int q = 8, r = 5, s;
  q = 7;
}
