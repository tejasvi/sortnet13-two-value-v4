#!/usr/bin/env python3
"""Write the corrupted data files of the negative controls (negctl/data/) from data/.
Each control changes one item of the certificate; the matching negctl/*.lean module must be rejected."""
import os
R = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
D = os.path.join(R, 'negctl', 'data')
os.makedirs(D, exist_ok=True)
src = open(os.path.join(R, 'data/c/c00500.txt')).read().split('\n')   # chunk 500: keys 39454..39534
first = src[0].split(' ')
e0 = first[0].split(':')                                              # ci, sg, tg, j

def write(name, lines):
    open(os.path.join(D, name + '.txt'), 'w').write('\n'.join(lines))

def with_first(entry):
    return [' '.join([':'.join(entry)] + first[1:])] + src[1:]

def perm_hex(p):
    return '%x' % sum(v << (4 * i) for i, v in enumerate(p))

sig = [(int(e0[1], 16) >> (4 * i)) & 15 for i in range(13)]
# A: wrong target index
a = list(e0); a[3] = str(int(a[3]) + 1); write('NegA_target', with_first(a))
# B1: sigma(0), sigma(1) swapped, inverse unchanged
s1 = list(sig); s1[0], s1[1] = sig[1], sig[0]
b1 = list(e0); b1[1] = perm_hex(s1); write('NegB1_sigma', with_first(b1))
# B2: sigma composed with the transposition (0 2), inverse updated
s2 = list(sig); s2[0], s2[2] = sig[2], sig[0]
inv2 = [0] * 13
for i, v in enumerate(s2): inv2[v] = i
b2 = list(e0); b2[1] = perm_hex(s2); b2[2] = perm_hex(inv2); write('NegB2_sigma_consistent', with_first(b2))
# C: first certificate entry removed
write('NegC_drop', [' '.join(first[1:])] + src[1:])
# G: unchanged data (the module claims a wrong length)
write('NegG_len', src)
# D, E: one field of a key changed (D: the target 56461 of the first entry of chunk 500; E: key 0)
keys = open(os.path.join(R, 'data/keys.txt')).read().split('\n')
P = (1 << 61) - 1
def corrupt(k_hex):
    raw = int(k_hex, 16) >> 64
    idx = 13 * 12 + 11                                     # field (12, 11)
    old = (raw >> (4 * idx)) & 15
    new = (old + 1) % 16 if old != 15 else 1
    raw2 = raw ^ ((old ^ new) << (4 * idx))
    return '%x' % ((raw2 << 64) + raw2 % P)
kD = list(keys); kD[int(e0[3])] = corrupt(keys[int(e0[3])]); write('keys_D', kD)
kE = list(keys); kE[0] = corrupt(keys[0]); write('keys_E', kE)
print('negative-control data written to negctl/data')
