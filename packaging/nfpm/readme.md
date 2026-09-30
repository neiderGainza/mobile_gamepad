<!-- Builds -->

nfpm package --config nfpm.yaml --packager deb
nfpm package --config nfpm.yaml --packager rpm
nfpm package --config nfpm.yaml --packager archlinux

