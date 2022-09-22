FROM amazonlinux:2 as BUILD
RUN yum -y install gcc
RUN curl https://static.rust-lang.org/rustup/dist/aarch64-unknown-linux-gnu/rustup-init --output rustup-init
RUN chmod +x rustup-init
RUN ./rustup-init -y --profile minimal
WORKDIR /app
COPY . .
RUN $HOME/.cargo/bin/cargo build --release


FROM amazonlinux:2 as RUN
WORKDIR /app
COPY --from=BUILD /app/target/release/rust_lambda .
CMD ["./rust_lambda"]




