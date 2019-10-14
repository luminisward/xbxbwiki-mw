<?php

/**
 * @codeCoverageIgnore
 */
class XBDBScribunto
{

 /**
  * @since 1.0
  */
    public static function onExtensionFunction()
    {
        Hooks::register('ScribuntoExternalLibraries', function ($engine, array &$extraLibraries) {
            $extraLibraries['mw.xbdb'] = 'XBDBScribuntoLuaLibrary';
            return true;
        });
    }
}
