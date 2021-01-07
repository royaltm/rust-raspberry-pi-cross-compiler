Rust Raspberry Pi Cross Compiler (for 32-bit Raspbian).
=======================================================

Based on: [sdthirlwall/raspberry-pi-cross-compiler](https://github.com/sdt/docker-raspberry-pi-cross-compiler).

Call `./build.sh` to build a docker image.

Use `rpxc` command to invoke commands in the docker container.

Additional command: `commit` added to rpxc that commits changes in the container after invoking a command.


Usage
-----

```
cd rust-repository
rpxc cargo build --release
```

builds an executable in `target/armv7-unknown-linux-gnueabihf/release/`
