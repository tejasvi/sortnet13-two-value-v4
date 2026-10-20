import S13Kernel.Data.Keys

/-! Keys number 97287 to 97399. `data/c/c01082.txt` has sha256 ed70b331fc6355ce2ea40efb8a7764e26ba10218f780677b1de0c489eaddc672. -/

namespace S13K.Chunks.C01082

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01082.txt"

theorem chk : chkChunk S N 97287 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 97287 97400 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01082
