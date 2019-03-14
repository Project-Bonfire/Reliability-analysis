--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO_control_part_input_wire is
    port (  
            valid_in  : in std_logic;
            read_en_N : in std_logic;
            read_en_E : in std_logic;
            read_en_W : in std_logic;
            read_en_S : in std_logic;
            read_en_L : in std_logic;

            valid_in_out  : out std_logic;
            read_en_N_out : out std_logic;
            read_en_E_out : out std_logic;
            read_en_W_out : out std_logic;
            read_en_S_out : out std_logic;
            read_en_L_out : out std_logic
         );
end FIFO_control_part_input_wire;

architecture behavior of FIFO_control_part_input_wire is

begin

  valid_in_out  <= valid_in;
  read_en_N_out <= read_en_N;
  read_en_E_out <= read_en_E;
  read_en_W_out <= read_en_W;
  read_en_S_out <= read_en_S;
  read_en_L_out <= read_en_L;

end;
