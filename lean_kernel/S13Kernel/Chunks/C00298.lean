import S13Kernel.Data.Keys

/-! Keys number 21605 to 21695. `data/c/c00298.txt` has sha256 33e28ee9096d2e07e0921be28d7cc4a203cdfce409ed89dec75f67fd9804c5f2. -/

namespace S13K.Chunks.C00298

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00298.txt"

theorem chk : chkChunk S N 21605 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 21605 21696 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00298
