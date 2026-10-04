<!-- Builds -->

Compile desktop and server, then on desktop and server folders and

nfpm package --config nfpm.yaml --packager deb
nfpm package --config nfpm.yaml --packager rpm
nfpm package --config nfpm.yaml --packager archlinux

