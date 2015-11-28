# nerbs

A ruby script for doing nerves development (code editing and firmware updates) from their Mac.

It works using `ssh` and `rsync` against a networked linux host with the nerves sdk already on it.

Get [fwup](https://github.com/nerves-project/nerves-sdk) to be able to write the firmware to your SD card once nerbs pulls it for you.

Currently it only pushes code, compiles a firmware, and pulls the firmware down. At most, I might add some helpers to switch your defconfig. My intent is to keep this an extremely lean alternative to [bakeware](https://github.com/bakeware) which I couldn't get working.

## Install

`sudo ln -s $PWD/nerbs.rb /usr/local/bin/nerbs.rb`

Then you can run `nerbs.rb` from your nerves project directory.
