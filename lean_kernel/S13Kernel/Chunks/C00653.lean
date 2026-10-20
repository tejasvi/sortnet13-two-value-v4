import S13Kernel.Data.Keys

/-! Keys number 53538 to 53645. `data/c/c00653.txt` has sha256 d40c9f5e7fa60ca00fd9a39c4c2f41462658328a40e69072b38e4f2eb895d208. -/

namespace S13K.Chunks.C00653

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00653.txt"

theorem chk : chkChunk S N 53538 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 53538 53646 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00653
