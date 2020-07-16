# Enable openssl for mysql2 ruby gem
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
