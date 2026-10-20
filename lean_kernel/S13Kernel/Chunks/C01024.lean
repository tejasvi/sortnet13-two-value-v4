import S13Kernel.Data.Keys

/-! Keys number 90708 to 90826. `data/c/c01024.txt` has sha256 1ddde551e6c208008ab0177c0695ed9fb3ca675b3cec75df517821a35ce32519. -/

namespace S13K.Chunks.C01024

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01024.txt"

theorem chk : chkChunk S N 90708 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 90708 90827 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01024
