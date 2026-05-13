# Limitations

## Package Availability

The `golang` resource installs official Go archives from `go.dev/dl` by default. Go publishes
Linux archives by operating system and architecture rather than by Linux distribution, so the same
archive URL pattern is used across supported Linux distributions.

### Official Linux Archives

* Go 1.26.3 is available as source and Linux archives for `386`, `amd64`, `arm64`, `armv6l`,
  `loong64`, `mips`, `mips64`, `mips64le`, `mipsle`, `ppc64`, `ppc64le`, `riscv64`, and `s390x`.
* This cookbook maps common Linux machines such as `x86_64`, `aarch64`, and `i386` to the matching
  Go archive architecture.

## Platform Support

The cookbook keeps non-EOL Linux platforms that can use the official Go Linux archives and removes
platforms whose standard support has ended.

* Ubuntu 22.04 and 24.04 remain supported. Ubuntu 20.04 standard support has ended.
* Debian 12 and 13 remain supported. Debian 11 standard support has ended.
* Amazon Linux 2023 remains supported. Amazon Linux 2 standard support ends 2026-06-30, but the
  current Chef/Cinc Workstation used by CI cannot execute on Amazon Linux 2 because its embedded
  Ruby requires newer `glibc`/`libcrypt` symbols than the platform provides.
* AlmaLinux, Oracle Linux, and Rocky Linux 8, 9, and 10 remain supported.
* CentOS Stream 9 and 10 remain supported. CentOS 7 and CentOS Stream 8 are EOL.
* Fedora latest remains supported.
* openSUSE Leap 15.6 is EOL as of 2026-04-30 and is not listed in the current Kitchen matrix.

## Source/Compiled Installation

### Build Dependencies

| Platform Family | Packages |
|-----------------|----------|
| Debian          | `build-essential`, plus configured SCM packages |
| RHEL/Fedora     | `build-essential` resolved by Chef, plus configured SCM packages |

Go source builds require a bootstrap Go toolchain. The resource downloads the configured binary Go
archive first, uses it as `GOROOT_BOOTSTRAP`, then removes the temporary bootstrap tree after a
successful build.

## Known Issues

The default `golang_package` install action uses `go install <module>@<version>`, which is the
supported module-aware installation flow for modern Go releases.
