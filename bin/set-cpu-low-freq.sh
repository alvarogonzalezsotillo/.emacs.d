
#!/bin/bash

# MAX IS 4200000
# MIN IS 400000
FREQ=4200000

for CPU in 0 1 2 3
do
    echo $FREQ | sudo tee /sys/devices/system/cpu/cpufreq/policy$CPU/scaling_max_freq
done
