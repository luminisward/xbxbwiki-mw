<?php

class XBDBScribuntoLuaLibrary extends Scribunto_LuaLibraryBase
{
    private $conn;
    private $tables;

    public function __construct(Scribunto_LuaEngine $engine)
    {
        parent::__construct($engine);

        $servername = "mysql";
        $username = "root";
        $password = "MjqVXTUhDgp4xsakiwT5";
        $dbname = 'mysql';

        $this->conn = new mysqli($servername, $username, $password, $dbname);
        if ($this->conn->connect_error) {
            throw new Exception("连接失败: " . $this->conn->connect_error);
        }

        $result = $this->conn->query("SHOW TABLES")->fetch_all();
        $this->tables = array_column($result, 0);
    }

    public function __destruct()
    {
        $this->conn->close();
    }

    public function register()
    {
        $lib = [
            'select' => [$this, 'select'],
        ];
        $this->getEngine()->registerInterface(__DIR__ . '/' . 'mw.xbdb.lua', $lib, []);
    }

    public function select($table, $fields, $conds = '')
    {
        if (!in_array($table, $this->tables)) {
            throw new Exception('Can\'t find table.');
        }

        $result = $this->conn->query("SHOW COLUMNS FROM $table")->fetch_all();
        $columns = array_column($result, 0);
        $columns[] = '*';

        if (is_string($fields) && !is_array($fields)) {
            $fields = array_map('trim', explode(',', $fields));
        }
        foreach ($fields as $field) {
            if (!in_array($field, $columns)) {
                throw new Exception("Can't find column: $field.");
            }
        }
        $fields = join(',', $fields);


        $data = [];
        $stmt = $this->conn->stmt_init();
        if ($stmt->prepare("SELECT $fields FROM $table")) {
            $stmt->execute();

            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }

            $stmt->close();
        }
        return [$data];
    }
}
