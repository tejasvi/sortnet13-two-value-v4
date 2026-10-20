import S13Kernel.Data.Keys

/-! Keys number 53646 to 53719. `data/c/c00654.txt` has sha256 4e874b884536291f002136fe57b7c2c67ace8f479aa64b282d6bb01ee285e094. -/

namespace S13K.Chunks.C00654

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00654.txt"

theorem chk : chkChunk S N 53646 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 53646 53720 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00654
