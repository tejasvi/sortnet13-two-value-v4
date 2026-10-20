import S13Kernel.Data.Keys

/-! Keys number 22480 to 22544. `data/c/c00309.txt` has sha256 8da7759611bcc5c3c331bd95eb3760e1ba242644e5d11c54943b209974c3ec2c. -/

namespace S13K.Chunks.C00309

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00309.txt"

theorem chk : chkChunk S N 22480 65 ces = true := by decide +kernel

theorem ok : RangeOK S N 22480 22545 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00309
