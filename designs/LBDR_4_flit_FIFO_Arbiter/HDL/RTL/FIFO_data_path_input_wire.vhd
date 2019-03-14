--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO_data_path_input_wire is
    generic (
        DATA_WIDTH: integer := 32
    );
    port (  
            write_en: in  std_logic;
            RX : in  std_logic_vector(DATA_WIDTH-1 downto 0);
            read_pointer, write_pointer: in std_logic_vector(3 downto 0);
            
            write_en_out: out  std_logic;
            RX_out : out  std_logic_vector(DATA_WIDTH-1 downto 0);
            read_ptr_out, write_ptr_out: out std_logic_vector(3 downto 0)
         );
end FIFO_data_path_input_wire;

architecture behavior of FIFO_data_path_input_wire is

begin

  write_en_out <= write_en;
  RX_out <= RX;
  read_ptr_out <= read_pointer;
  write_ptr_out <= write_pointer;

end;
