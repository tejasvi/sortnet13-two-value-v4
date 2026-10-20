import S13Kernel.Data.Keys

/-! Keys number 76821 to 76918. `data/c/c00892.txt` has sha256 36e6e3d69e9a05cff0e96870acecc841a1cee7edcfa89688f6c606fa5fd62747. -/

namespace S13K.Chunks.C00892

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00892.txt"

theorem chk : chkChunk S N 76821 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 76821 76919 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00892
