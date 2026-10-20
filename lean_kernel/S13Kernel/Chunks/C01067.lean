import S13Kernel.Data.Keys

/-! Keys number 95504 to 95619. `data/c/c01067.txt` has sha256 1daa42776ae8396cc00cc0b291ac499652332e6edaf4c1444ba56b2e27300769. -/

namespace S13K.Chunks.C01067

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01067.txt"

theorem chk : chkChunk S N 95504 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 95504 95620 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01067
