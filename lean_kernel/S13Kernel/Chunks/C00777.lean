import S13Kernel.Data.Keys

/-! Keys number 65552 to 65639. `data/c/c00777.txt` has sha256 db4fa62f401c8ab11ae4c558b36cc2b9c82313cfe7f5fd940417e1581733a8f1. -/

namespace S13K.Chunks.C00777

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00777.txt"

theorem chk : chkChunk S N 65552 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 65552 65640 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00777
