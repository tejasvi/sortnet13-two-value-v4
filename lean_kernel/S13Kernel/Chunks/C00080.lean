import S13Kernel.Data.Keys

/-! Keys number 4706 to 4784. `data/c/c00080.txt` has sha256 b3cd422fe1a17b101abd36d63a476ced23b257d7e19ee13a955c0e47c7cdd4cc. -/

namespace S13K.Chunks.C00080

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00080.txt"

theorem chk : chkChunk S N 4706 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 4706 4785 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00080
