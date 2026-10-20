// Statistics of Harder's proof certificate (format: snocheck/src/Decode.hs).
#include <bits/stdc++.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
using namespace std;
static inline uint64_t rd(const uint8_t* p, int n){ uint64_t v=0; for(int i=0;i<n;i++) v|=(uint64_t)p[i]<<(8*i); return v; }
int main(int argc,char**argv){
  int fd=open(argv[1],O_RDONLY); struct stat st; fstat(fd,&st); size_t sz=st.st_size;
  const uint8_t* d=(const uint8_t*)mmap(nullptr,sz,PROT_READ,MAP_PRIVATE,fd,0);
  uint32_t n=rd(d,4); printf("steps=%u filesize=%zu\n",n,sz);
  map<int,long long> byW, setBytesW, witBytesW, popW; map<int,long long> huff, succ, nothing, wits; map<pair<int,int>,long long> wb;
  long long totSet=0,totWit=0,totHdr=12LL*n+4; long long maxPop=0; vector<long long> popHist(4097,0);
  long long distSum=0, distCnt=0; vector<long long> distHist(40,0);
  long long succNothing=0, succWit=0, huffWit=0, huffNothing=0;
  for(uint32_t s=0;s<n;s++){
    const uint8_t* h=d+4+12ull*s; uint64_t off=rd(h,8); uint32_t len=rd(h+8,4); const uint8_t* p=d+off;
    int ch=p[0], b=p[1]; int setLen= ch>=3 ? (1<<(ch-3)) : 1;
    long long pop=0; for(int i=0;i<setLen;i++) pop+=__builtin_popcount(p[2+i]);
    popHist[min<long long>(pop,4096)]++; maxPop=max(maxPop,pop);
    byW[ch]++; setBytesW[ch]+=setLen; witBytesW[ch]+=len-2-setLen; popW[ch]+=pop; wb[{ch,b}]++;
    totSet+=setLen+2; totWit+=len-2-setLen;
    const uint8_t* w=p+2+setLen; int type=w[0]; int wch = type==2? ch : ch-1;
    if(type==2) succ[ch]++; else huff[ch]++;
    const uint8_t* q=w+1; const uint8_t* end=p+len;
    while(q<end){ int tag=*q++; if(tag==2){ if(type==2) succNothing++; else huffNothing++; continue; }
      q+=wch; uint32_t id=rd(q,4); q+=4; if(type==2) succWit++; else huffWit++;
      long long dist=(long long)s-id; distSum+=dist; distCnt++; int lg=0; while((1LL<<lg)<=dist && lg<39) lg++; distHist[lg]++; }
  }
  printf("total set bytes=%lld witness bytes=%lld header bytes=%lld\n",totSet,totWit,totHdr);
  for(auto&kv:byW){ int c=kv.first; printf("width %2d: steps=%9lld succ=%9lld huff=%9lld setBytes=%11lld witBytes=%11lld meanPop=%.1f\n",c,kv.second,succ[c],huff[c],setBytesW[c],witBytesW[c],(double)popW[c]/kv.second); }
  printf("succ witnesses=%lld nothing=%lld; huff witnesses=%lld nothing=%lld\n",succWit,succNothing,huffWit,huffNothing);
  printf("mean witness distance=%.1f\n",(double)distSum/distCnt);
  printf("distance log2 hist:"); for(int i=0;i<40;i++) if(distHist[i]) printf(" %d:%lld",i,distHist[i]); printf("\n");
  printf("max pop=%lld\npop quantiles:",maxPop); long long acc=0; long long tot=n; double qs[]={0.1,0.25,0.5,0.75,0.9,0.99,1.0}; int qi=0;
  for(int i=0;i<=4096 && qi<7;i++){ acc+=popHist[i]; while(qi<7 && acc>=qs[qi]*tot){ printf(" q%.2f=%d",qs[qi],i); qi++; } } printf("\n");
  printf("(width,bound) counts:"); for(auto&kv:wb) printf(" (%d,%d):%lld",kv.first.first,kv.first.second,kv.second); printf("\n");
}
