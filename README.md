** See this instead https://gist.github.com/kfatehi/f04be4e43602cd014c13 **

---

# nerbs

A ruby script for doing nerves development (code editing and firmware updates) from their Mac.

It works using `ssh` and `rsync` against a networked linux host with the nerves sdk already on it.

You need [fwup](https://github.com/nerves-project/nerves-sdk) to run the `burn-complete` and `burn-upgrade` tasks.

## Install

Execute `nerbs.rb` from your nerves project directory.

**It uses the `USER` and `NERVES_SDK_HOST` environment variables to compose `rsync` and `ssh` targets, so make sure they are set**

## Tasks

* build - shorthand for push, compile, and pull
* push - uploads project source code with `rsync`
* compile - pushes source code, sources sdk, and compiles remotely with `ssh`
* pull - downloads the `_images` directory
* burn-complete - writes the complete image with `fwup`
* burn-upgrade - writes the upgrade image with `fwup`
