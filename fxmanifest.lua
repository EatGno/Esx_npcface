fx_version 'cerulean'
game 'gta5'

author 'parisrp'
description 'Applique la tête du joueur à un modèle spécifique'
version '1.0.0'

client_scripts {
    'client/main.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- Pour la gestion de la base de données
    'server/main.lua',
}

dependencies {
    'es_extended',
}
