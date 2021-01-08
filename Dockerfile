FROM sdthirlwall/raspberry-pi-cross-compiler

RUN install-debian --update libssl-dev pkgconf
RUN install-raspbian --update libxkbcommon-dev libwayland-dev libasound2-dev libssl-dev pkgconf

# to help guiding rust pkg_config
ENV TARGET_PKG_CONFIG_PATH=
ENV TARGET_PKG_CONFIG_SYSROOT_DIR=${SYSROOT}
ENV TARGET_PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig:${SYSROOT}/usr/lib/arm-linux-gnueabihf/pkgconfig

# fix for libpthread.so
RUN ln -fs $SYSROOT/lib/arm-linux-gnueabihf /lib/arm-linux-gnueabihf && \
    ln -fs $SYSROOT/usr/lib/arm-linux-gnueabihf /usr/lib/arm-linux-gnueabihf

RUN mkdir -p /opt/rust/
ENV CARGO_HOME=/opt/rust/cargo
ENV RUSTUP_HOME=/opt/rust/rustup
RUN umask 0000 && curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y
ENV PATH=/opt/rust/cargo/bin:$PATH
RUN umask 0000 && rustup default stable
RUN umask 0000 && rustup target add armv7-unknown-linux-gnueabihf

COPY ./configure.sh /root/configure.sh
RUN /root/configure.sh

# update rpxc script
COPY ./rpxc.sh /rpxc/rpxc

# check compilation
RUN USER=root cargo init --bin hello && \
  cd hello && \
  cargo build --release --target=armv7-unknown-linux-gnueabihf && \
  arm-linux-gnueabihf-strip target/armv7-unknown-linux-gnueabihf/release/hello && \
  install -m 755 target/armv7-unknown-linux-gnueabihf/release/hello $SYSROOT/bin/
RUN rm -rf hello
RUN rpdo hello
