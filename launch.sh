#! /bin/bash
# can do either "source launch.sh" or "source launch.sh fast" to skip constants loading
./configure.sh $1 && ./connect.sh && ./run.sh && ssb_status_main --slot 7
