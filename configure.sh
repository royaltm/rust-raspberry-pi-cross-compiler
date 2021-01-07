echo creating: $CARGO_HOME/config
mkdir -p $CARGO_HOME
cat >>$CARGO_HOME/config <<EOF
[target.armv7-unknown-linux-gnueabihf]
linker = "arm-linux-gnueabihf-gcc"

[build]
target = "armv7-unknown-linux-gnueabihf"
EOF
