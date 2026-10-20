// f-state of a network, computed with the state transition of bf2.cpp of the clean-room verification
// (`apply`, copied without its pruning tests). Reads lines "N lo,hi lo,hi ...", prints the
// N*N entries (0 = no run, else 1 + max cost), row-major.
#include <bits/stdc++.h>
using namespace std;
int N;
struct St { int8_t v[256]; };
void apply(const St& s, int lo, int hi, St& t) {  // bf2.cpp apply, pruning removed, L unbounded
  memset(t.v, -1, 256);
  for (int p = 0; p < N; p++) for (int q = 0; q < N; q++) { if (p == q) continue; int c = s.v[p*16+q]; if (c < 0) continue;
    int pM = p, pm = q; bool iM = (pM == lo || pM == hi), im = (pm == lo || pm == hi);
    if (iM || im) { c++; if (iM && im) { pM = hi; pm = lo; } else if (iM) pM = hi; else pm = hi; }
    int8_t &d = t.v[pM*16+pm]; if (c > d) d = (int8_t)c; }
}
int main() {
  string line;
  while (getline(cin, line)) {
    istringstream in(line); in >> N; St s; memset(s.v, -1, 256);
    for (int p = 0; p < N; p++) for (int q = 0; q < N; q++) if (p != q) s.v[p*16+q] = 0;
    string tok;
    while (in >> tok) { int a, b; sscanf(tok.c_str(), "%d,%d", &a, &b); St t; apply(s, a, b, t); s = t; }
    for (int p = 0; p < N; p++) for (int q = 0; q < N; q++) { int c = s.v[p*16+q]; printf("%s%d", (p||q) ? " " : "", c < 0 ? 0 : c + 1); }
    printf("\n");
  }
}
