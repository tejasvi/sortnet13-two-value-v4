import S13Kernel.Data.Keys

/-! Keys number 42132 to 42230. `data/c/c00530.txt` has sha256 0279e935463f0dcda7885174ff222f18cc1d551ad89fd42645c6a80634bcab76. -/

namespace S13K.Chunks.C00530

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00530.txt"

theorem chk : chkChunk S N 42132 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 42132 42231 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00530
