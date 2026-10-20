import S13Kernel.Data.Keys

/-! Keys number 98483 to 98604. `data/c/c01092.txt` has sha256 703f71418794ed127fd14fb80bc49b8dee5bd926ef3ed65baac6a0b8846918b0. -/

namespace S13K.Chunks.C01092

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01092.txt"

theorem chk : chkChunk S N 98483 122 ces = true := by decide +kernel

theorem ok : RangeOK S N 98483 98605 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01092
