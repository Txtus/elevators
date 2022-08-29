Config = {}

Config.language = "en"

Config.debug = true

Config.MarkerColor = {
    r = 0,
    g = 0,
    b = 0
}

function debug(msg) 
    if Config.debug then 
        print("[^1DEBUG^0]: "..msg)
    end
end
