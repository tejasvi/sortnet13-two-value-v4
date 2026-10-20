import S13Kernel.Data.Keys

/-! Keys number 66975 to 67068. `data/c/c00793.txt` has sha256 015a61093913fe58d3a499ef5aaf1deebbc3bc570e05dca355f03515ff6ae487. -/

namespace S13K.Chunks.C00793

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00793.txt"

theorem chk : chkChunk S N 66975 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 66975 67069 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00793
