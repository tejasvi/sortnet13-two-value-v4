import S13Kernel.Data.Keys

/-! Keys number 19804 to 19872. `data/c/c00273.txt` has sha256 a2ad0c7bdb06cbb12330f53c10b7bcb8416894b35716031298ff7ef17d6742eb. -/

namespace S13K.Chunks.C00273

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00273.txt"

theorem chk : chkChunk S N 19804 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 19804 19873 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00273
