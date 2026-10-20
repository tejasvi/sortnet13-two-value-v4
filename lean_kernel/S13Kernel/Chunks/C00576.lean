import S13Kernel.Data.Keys

/-! Keys number 46557 to 46642. `data/c/c00576.txt` has sha256 da845969af5f7b663548b47e5fb4316b4fbb9db9e4226318a830397d879a5770. -/

namespace S13K.Chunks.C00576

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00576.txt"

theorem chk : chkChunk S N 46557 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 46557 46643 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00576
