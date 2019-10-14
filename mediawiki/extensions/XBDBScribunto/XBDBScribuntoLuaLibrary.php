<?php

class XBDBScribuntoLuaLibrary extends Scribunto_LuaLibraryBase
{
    private $conn;
    private $tables;

    public function __construct(Scribunto_LuaEngine $engine)
    {
        parent::__construct($engine);

        global $wgXBDBScribuntoConnection;
        $servername = $wgXBDBScribuntoConnection["servername"];
        $username   = $wgXBDBScribuntoConnection["username"];
        $password   = $wgXBDBScribuntoConnection["password"];
        $dbname     = $wgXBDBScribuntoConnection["dbname"];

        $e = function_exists(pg_connect);

        $this->conn = new PDO("pgsql:host=$servername;dbname=$dbname;user=$username;password=$password");
        if (!$this->conn) {
            throw new Exception("连接失败: " . $this->conn->connect_error);
        }
    }

    // public function __destruct()
    // {
    //     $this->conn = null;
    // }

    public function register()
    {
        $lib = [
            'query' => [$this, 'query'],
        ];
        $this->getEngine()->registerInterface(__DIR__ . '/' . 'mw.xbdb.lua', $lib, []);
    }

    public function query($sql, $schema)
    {
        $this->conn->exec("SET search_path TO $schema");
        $stocks = [];
        if ($stmt = $this->conn->query($sql)) {
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $stocks[] = $row;
            }
        } else {
            throw new Exception("Wrong SQL:\n $sql");
        }

        array_unshift($stocks, '');
        unset($stocks[0]);

        return [$stocks];
    }
}
