import S13Kernel.Data.Keys

/-! Keys number 70719 to 70803. `data/c/c00831.txt` has sha256 f6e500c75933452a6d36b1b78b758398e51178b544b9926ff2eebe96aab607fe. -/

namespace S13K.Chunks.C00831

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00831.txt"

theorem chk : chkChunk S N 70719 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 70719 70804 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00831
