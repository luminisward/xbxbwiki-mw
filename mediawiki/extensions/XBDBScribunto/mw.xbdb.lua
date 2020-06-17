local xbdb = {}
local php

function xbdb.setupInterface( options )
    -- Remove setup function
    xbdb.setupInterface = nil

    -- Copy the PHP callbacks to a local variable, and remove the global
    php = mw_interface
    mw_interface = nil

    -- Do any other setup here

    -- Install into the mw global
    mw = mw or {}
    mw.xbdb = xbdb

    -- Indicate that we're loaded
    package.loaded['mw.xbdb'] = xbdb
end

function xbdb.query(sql,schema)
  schema = schema or 'cn'
  return php.query(sql,schema)
end

function xbdb.post(url, data)
  return php.post(url, data)
end

function xbdb.env()
  return php.env()
end

return xbdb
