fx_version 'adamant'

game 'gta5'

description 'enter description'
author 'enter author'
version '0.1'

shared_scripts {
	'shared/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

ui_page {
	'html/html.html'
}

files {
    'html/html.html',
	'html/assets/js/*.js',
	'html/assets/css/*.css',
    'html/assets/fonts/*.ttf',
    'html/assets/img/*.png',
}