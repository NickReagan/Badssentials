author "Badger#0002"
description "Badssenstials"
fx_version "cerulean"
game "gta5"

client_script "client/client.lua"

server_script "server.lua"

shared_scripts {
    "config.lua",
    "postals.lua",
    "functions.lua",
}

exports {
    "GetAOP",
    "GetPeaceTimeStatus",
    "IsDisplaysHidden"
}

-- NUI Default Page
ui_page "client/html/index.html"

-- Files needed for NUI
files {
    'client/html/index.html',
    'client/html/sounds/*.ogg'
}
