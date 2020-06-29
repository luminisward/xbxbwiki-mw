<?php

use MediaWiki\MediaWikiServices;

class XBDBScribuntoLuaLibrary extends Scribunto_LuaLibraryBase
{
    private $conn;
    private $tables;
    private $conn_error;

    private function connectDb()
    {
        global $wgXBDBScribuntoConnection;
        $servername = $wgXBDBScribuntoConnection["servername"];
        $username   = $wgXBDBScribuntoConnection["username"];
        $password   = $wgXBDBScribuntoConnection["password"];
        $dbname     = $wgXBDBScribuntoConnection["dbname"];

        try {
            $this->conn = new PDO("pgsql:host=$servername;dbname=$dbname;user=$username;password=$password");
        } catch (\Throwable $th) {
            $this->conn_error = $th;
        }
        if ($this->conn->connect_error) {
            $this->conn_error = new Exception("连接失败: " . $this->conn->connect_error);
        }
        if ($this->conn_error) {
            throw $this->conn_error;
        }
    }

    public function __construct(Scribunto_LuaEngine $engine)
    {
        parent::__construct($engine);
        // $this->connectDb();
    }

    // public function __destruct()
    // {
    //     $this->conn = null;
    // }

    public function register()
    {
        $lib = [
            'query' => [$this, 'query'],
            'post'  => [$this, 'post'],
            'env'  => [$this, 'env'],
        ];
        $this->getEngine()->registerInterface(__DIR__ . '/' . 'mw.xbdb.lua', $lib, []);
    }

    public function query($sql, $schema)
    {

        if (is_null($this->conn)) {
            $this->connectDb();
        }

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

    public function post($entrypoint, $postData)
    {
        global $wgXBDBScribuntoPostEntrypoints;
        if (!in_array($entrypoint, $wgXBDBScribuntoPostEntrypoints)) {
            throw new Exception($entrypoint . ' not in $wgXBDBScribuntoPostEntrypoints');
        }
        $response = MediaWikiServices::getInstance()->getHttpRequestFactory()->post($entrypoint, [
            'postData' => $postData,
        ]);

        $stocks = json_decode($response, true);

        array_unshift($stocks, '');
        unset($stocks[0]);

        return [$stocks];

    }

    public function env()
    {
        global $environment;
        return [$environment];
    }

}
