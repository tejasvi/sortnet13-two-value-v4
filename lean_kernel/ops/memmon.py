#!/usr/bin/env python3
"""Sample every lean process every 2 s: peak RSS (VmHWM) per module, minimum MemAvailable.
usage: memmon.py OUT.json   (stops when OUT.json.stop exists)"""
import os, sys, time, json
out = sys.argv[1]
cwd = os.getcwd()
peak, minavail, start, maxalive = {}, None, time.time(), 0
while True:
    alive = 0
    for pid in os.listdir('/proc'):
        if not pid.isdigit():
            continue
        try:
            cmd = open(f'/proc/{pid}/cmdline', 'rb').read().split(b'\0')
            if not cmd or not cmd[0].endswith(b'/bin/lean'):
                continue
            mod = next((c.decode() for c in cmd if c.endswith(b'.lean')), '?')
            mod = os.path.relpath(mod, cwd) if mod.startswith('/') else mod
            hwm = 0
            for line in open(f'/proc/{pid}/status'):
                if line.startswith('VmHWM:'):
                    hwm = int(line.split()[1])
            peak[mod] = max(peak.get(mod, 0), hwm)
            alive += 1
        except Exception:
            pass
    maxalive = max(maxalive, alive)
    avail = int([l for l in open('/proc/meminfo') if l.startswith('MemAvailable')][0].split()[1])
    minavail = avail if minavail is None else min(minavail, avail)
    with open(out + '.tmp', 'w') as f:
        json.dump({'elapsed_s': time.time() - start, 'min_memavailable_kb': minavail,
                   'max_concurrent_lean': maxalive, 'peak_rss_kb': peak}, f)
    os.replace(out + '.tmp', out)
    if os.path.exists(out + '.stop'):
        break
    time.sleep(2)
