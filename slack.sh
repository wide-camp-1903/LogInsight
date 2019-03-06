#!/usr/bin/env bash

if [[ $# -lt 5 ]]; then
    echo "Usage: $0 message displayName category stringseverity strModTime"
    exit 1
fi

message=$1
displayName=$2
category=$3
stringseverity=$4
strModTime=$5

if [[ ${stringseverity} == "Clear" ]]; then
    color="good"
elif [[ ${stringseverity} == "Trouble" ]]; then
    color="warning"
elif [[ ${stringseverity} == "Critical" ]]; then
    color="danger"
else
    exit 0
    color="gray"
fi

payload=`cat << EOS
    payload={
        "attachments": [{
            "color": "${color}",
            "title": "$stringseverity - ${displayName}",
            "text": "メッセージ: ${message}\n発生元: ${displayName}\nカテゴリー: ${category}\n発生時刻: ${strModTime}"
        }]
    }
EOS`

curl -X POST --data-urlencode "${payload}" https://hooks.slack.com/services/TXXXXXXXX/BXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX
