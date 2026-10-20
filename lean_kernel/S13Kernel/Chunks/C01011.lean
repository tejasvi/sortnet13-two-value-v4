import S13Kernel.Data.Keys

/-! Keys number 89265 to 89369. `data/c/c01011.txt` has sha256 32c699c3d4c8d6c08f5324661eb75c69822a0341018fa21b2ddfdfeb5e10c954. -/

namespace S13K.Chunks.C01011

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01011.txt"

theorem chk : chkChunk S N 89265 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 89265 89370 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01011
