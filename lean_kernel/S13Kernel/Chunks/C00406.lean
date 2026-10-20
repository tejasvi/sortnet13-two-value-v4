import S13Kernel.Data.Keys

/-! Keys number 31256 to 31340. `data/c/c00406.txt` has sha256 6211b9172ef3500dcf08a0ab35b1a900cfcad3665d7fbc2bbcac62a106904934. -/

namespace S13K.Chunks.C00406

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00406.txt"

theorem chk : chkChunk S N 31256 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 31256 31341 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00406
