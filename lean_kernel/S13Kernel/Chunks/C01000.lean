import S13Kernel.Data.Keys

/-! Keys number 88006 to 88121. `data/c/c01000.txt` has sha256 d53b5a1e12e838cd48982e2890e4c2c817c4d73aa78ff97e411c28f8879dfbc0. -/

namespace S13K.Chunks.C01000

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01000.txt"

theorem chk : chkChunk S N 88006 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 88006 88122 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01000
