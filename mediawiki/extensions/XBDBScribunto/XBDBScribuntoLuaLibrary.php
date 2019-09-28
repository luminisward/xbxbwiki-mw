<?php

class XBDBScribuntoLuaLibrary extends Scribunto_LuaLibraryBase
{
    public function register()
    {
        $lib = [
            't' => [$this, 't'],
        ];

        $this->getEngine()->registerInterface(__DIR__ . '/' . 'mw.xbdb.lua', $lib, []);
    }

    public function t($arguments = null)
    {
        return ['12343312341444'];
    }
}
