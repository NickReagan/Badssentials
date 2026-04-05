author "badger.jar"
description "Badssenstials"
fx_version "cerulean"
game "gta5"
version '3.0.0'

client_script "client/client.lua"

server_scripts {
    "server.lua",
    "version-checker.lua"
} 

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
