# run nvim --headless for 120 seconds

import subprocess
import time

nvim = subprocess.Popen(["nvim", "--headless"])
time.sleep(120)
nvim.kill()
