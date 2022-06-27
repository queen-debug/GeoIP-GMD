
geoip = geoip or {}

geoip.address = "http://ip-api.com/json/" 

function geoip.info(ip, callback)
    HTTP({
        url = (geoip.address .. ip),
        method = "GET",

        success = function(code, body, headers)
            local JSON = util.JSONToTable(body)
            
            if not JSON then
                return
            end

            callback(JSON)
        end,

        failed = function(reason)
            print("[GeoIP] " .. reason)
        end
    })
end

geoip.info("24.48.0.1", function(data)
    local country = data.country
    local city = data.city
    local ip = data.query

    print(string.format("Country: %s\nCity: %s\nQuery IP: %s", country, city, ip))
end)
