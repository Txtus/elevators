fx_version 'adamant'

game 'gta5'

description 'A elevator script'
author 'Titus#8023 from Tj5'
version '1.0'

shared_scripts {
	'shared/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

client_scripts {
	'@NativeUI/NativeUI.lua',
	'client/*.lua'
}


dependency {
	"NativeUI"
}
