import S13Kernel.Data.Keys

/-! Keys number 79622 to 79714. `data/c/c00919.txt` has sha256 fc12ae7d8199ffe30ccb3259503d8624209eb1fd560d26de953ab6dc4b59e867. -/

namespace S13K.Chunks.C00919

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00919.txt"

theorem chk : chkChunk S N 79622 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 79622 79715 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00919
