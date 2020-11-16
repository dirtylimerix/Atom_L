export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export TOP_DIR=$SCRIPT_DIR/..

# add Android SDK platform tools to path
if [ -d "$TOP_DIR/tools/platform-tools" ] ; then
  PATH="$TOP_DIR/tools/platform-tools:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$TOP_DIR/tools/bin" ] ; then
  PATH="$TOP_DIR/tools/bin:$PATH"
fi

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_COMPRESS=1

