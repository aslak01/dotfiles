# deno
export DENOPATH="$HOME/.deno"
if [ -d $DENOPATH ]; then
    [[ :$PATH: == *":$DENOPATH/bin:"* ]] || PATH+=":$DENOPATH/bin"
fi
