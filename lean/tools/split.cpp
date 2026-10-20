// Split a converted certificate into 64 MiB chunk files; print "name size fnv1a64" per chunk.
#include <bits/stdc++.h>
using namespace std;
int main(int argc, char** argv) {
  if (argc < 3) { fprintf(stderr, "usage: split CERT OUTDIR\n"); return 1; }
  const size_t CH = 64ull << 20;
  FILE* f = fopen(argv[1], "rb");
  vector<unsigned char> buf(CH);
  for (int k = 0;; k++) {
    size_t n = fread(buf.data(), 1, CH, f);
    if (n == 0) break;
    uint64_t h = 0xcbf29ce484222325ull;
    for (size_t i = 0; i < n; i++) { if (buf[i] >= 128) { fprintf(stderr, "byte >= 128\n"); return 1; } h = (h ^ buf[i]) * 0x100000001b3ull; }
    char name[64]; snprintf(name, sizeof name, "c%02d.s7", k);
    string path = string(argv[2]) + "/" + name;
    FILE* g = fopen(path.c_str(), "wb"); fwrite(buf.data(), 1, n, g); fclose(g);
    printf("%s %zu %llu\n", name, n, (unsigned long long)h);
  }
}
