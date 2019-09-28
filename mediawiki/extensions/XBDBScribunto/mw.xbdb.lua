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

function xbdb.test(parameters)
  return php.t()
end

return xbdb
