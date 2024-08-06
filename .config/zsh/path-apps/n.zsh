# version managed Node
export N_CACHE_PREFIX="$HOME/n"
if [ -d $N_CACHE_PREFIX ]; then
    [[ :$PATH: == *":$N_CACHE_PREFIX/bin:"* ]] || PATH+=":$N_CACHE_PREFIX/bin"
fi
