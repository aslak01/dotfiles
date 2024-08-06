for file in * do
  [ "${file}" != index.zsh ] && [ -s "${file}" ] && source "${file}"
done
