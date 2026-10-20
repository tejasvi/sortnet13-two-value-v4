import S13Kernel.Data.Keys

/-! Keys number 1022 to 1061. `data/c/c00022.txt` has sha256 e79481a23ee9588554ffe01f42a1a156fc138dfed5cd98a3692d8bb00f187393. -/

namespace S13K.Chunks.C00022

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00022.txt"

theorem chk : chkChunk S N 1022 40 ces = true := by decide +kernel

theorem ok : RangeOK S N 1022 1062 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00022
