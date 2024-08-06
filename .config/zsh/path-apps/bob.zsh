# bob (nvim)
export BOBPATH="$HOME/.local/share/bob"
if [ -d $BOBPATH ]; then
    [[ :$PATH: == *":$BOBPATH/nvim-bin:"* ]] || PATH+=":$BOBPATH/nvim-bin"
fi

