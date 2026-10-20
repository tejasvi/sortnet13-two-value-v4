// Convert Harder's proof certificate (snocheck/src/Decode.hs format) to the 7-bit character format
// read by S11Comp.lean. Output: 4 characters step count, then the steps.
// Step: w, b, kind (0/1 Huffman polarity, 2 successor), number of witnesses, bitmap (7 bits per char,
// ceil(2^w/7) chars), then 8 chars per witness: 4 chars tag + 4*id, 4 chars Lehmer code of the perm.
#include <bits/stdc++.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
using namespace std;
static inline uint64_t rd(const uint8_t* p, int n){ uint64_t v=0; for(int i=0;i<n;i++) v|=(uint64_t)p[i]<<(8*i); return v; }
static void put7(vector<uint8_t>& o, uint64_t v, int k){ for(int i=0;i<k;i++){ o.push_back(v & 127); v >>= 7; } if(v){ fprintf(stderr,"value too large\n"); exit(1);} }
static uint64_t fact(int n){ uint64_t f=1; for(int i=2;i<=n;i++) f*=i; return f; }
int main(int argc,char**argv){
  if(argc<3){ fprintf(stderr,"usage: convert IN OUT [maxsteps]\n"); return 1; }
  int fd=open(argv[1],O_RDONLY); struct stat st; fstat(fd,&st); size_t sz=st.st_size;
  const uint8_t* d=(const uint8_t*)mmap(nullptr,sz,PROT_READ,MAP_PRIVATE,fd,0);
  uint32_t n=rd(d,4);
  FILE* out=fopen(argv[2],"wb");
  vector<uint8_t> o; o.reserve(1<<24);
  put7(o,n,4);
  long long totalWit=0;
  for(uint32_t s=0;s<n;s++){
    const uint8_t* h=d+4+12ull*s; uint64_t off=rd(h,8); uint32_t len=rd(h+8,4); const uint8_t* p=d+off; const uint8_t* end=p+len;
    int w=p[0], b=p[1]; int setLen = w>=3 ? (1<<(w-3)) : 1;
    const uint8_t* bm=p+2; const uint8_t* wd=p+2+setLen; int type=wd[0]; int wch = type==2 ? w : w-1;
    // witnesses
    vector<array<uint64_t,2>> wits;
    const uint8_t* q=wd+1;
    while(q<end){ int tag=*q++; if(tag==2){ wits.push_back({2,0}); continue; }
      vector<int> perm(q,q+wch); q+=wch; uint32_t id=rd(q,4); q+=4;
      // Lehmer code
      vector<int> avail(wch); iota(avail.begin(),avail.end(),0); uint64_t code=0;
      for(int k=0;k<wch;k++){ auto it=find(avail.begin(),avail.end(),perm[k]); if(it==avail.end()){ fprintf(stderr,"bad perm at step %u\n",s); return 1; }
        code += (uint64_t)(it-avail.begin()) * fact(wch-1-k); avail.erase(it); }
      wits.push_back({(uint64_t)tag + 4ull*id, code}); }
    if(wits.size()>127){ fprintf(stderr,"too many witnesses\n"); return 1; }
    o.push_back(w); o.push_back(b); o.push_back(type); o.push_back((uint8_t)wits.size());
    int nbits=1<<w; int nchars=(nbits+6)/7;
    for(int c=0;c<nchars;c++){ int v=0; for(int j=0;j<7;j++){ int x=7*c+j; if(x<nbits && (bm[x>>3]>>(x&7)&1)) v|=1<<j; } o.push_back(v); }
    for(auto& wt: wits){ put7(o,wt[0],4); put7(o,wt[1],4); }
    totalWit+=wits.size();
    if(o.size()>(1u<<24)){ fwrite(o.data(),1,o.size(),out); o.clear(); }
  }
  fwrite(o.data(),1,o.size(),out); fclose(out);
  fprintf(stderr,"steps=%u witnesses=%lld\n",n,totalWit);
}
