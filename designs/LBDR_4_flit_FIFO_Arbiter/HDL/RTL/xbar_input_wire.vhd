--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;

entity xbar_input_wire is
    generic (
        DATA_WIDTH: integer := 32
    );
    port (
        North_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        East_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        West_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        South_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        Local_in: in std_logic_vector(DATA_WIDTH-1 downto 0);
        sel: in std_logic_vector (4 downto 0);

        North_in_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        East_in_out:  out std_logic_vector(DATA_WIDTH-1 downto 0);
        West_in_out:  out std_logic_vector(DATA_WIDTH-1 downto 0);
        South_in_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        Local_in_out: out std_logic_vector(DATA_WIDTH-1 downto 0);
        sel_out: out std_logic_vector (4 downto 0)
    );
end;

architecture behavior of xbar_input_wire is

begin

    North_in_out <= North_in;
    East_in_out  <= East_in;
    West_in_out  <= West_in;
    South_in_out <= South_in;
    Local_in_out <= Local_in;
    sel_out <= sel;

end;