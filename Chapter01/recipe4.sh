xcode-select --install

curl -LO https://mac.r-project.org/tools/gfortran-12.0.1-20220312-is-darwin20-arm64.tar.xz
sudo tar xvf gfortran-12.0.1-20220312-is-darwin20-arm64.tar.xz -C /
sudo ln -sfn $(xcrun --show-sdk-path) /opt/R/arm64/gfortran/SDK

wget https://mac.r-project.org/openmp/openmp-12.0.1-darwin20-Release.tar.gz
sudo tar xvf openmp-12.0.1-darwin20-Release.tar.gz -C

CPPFLAGS+=-I/usr/local/include -Xclang -fopenmp
LDFLAGS+=-L/usr/local/lib -lomp
FC=/opt/R/arm64/gfortran/bin/gfortran -mtune=native
FLIBS=-L/opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.6.0/12.0.1 -L/opt/R/arm64/gfortran/lib -lgfortran -lemutls_w -lm
