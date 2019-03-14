--Copyright (C) 2016 Siavoosh Payandeh Azad Behrad Niazmand

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.ALL;

entity LBDR_input_wire is
    port (  
            -- Inputs
            empty: in  std_logic;
            flit_type: in std_logic_vector(2 downto 0);
            cur_addr_y, cur_addr_x: in std_logic_vector(6 downto 0);
            dst_addr_y, dst_addr_x: in std_logic_vector(6 downto 0);
            grant_N, grant_E, grant_W, grant_S, grant_L: in std_logic;

            -- Outputs
            empty_out: out  std_logic;
            flit_type_out: out std_logic_vector(2 downto 0);
            cur_addr_y_out, cur_addr_x_out: out std_logic_vector(6 downto 0);
            dst_addr_y_out, dst_addr_x_out: out std_logic_vector(6 downto 0);
            grant_N_out, grant_E_out, grant_W_out, grant_S_out, grant_L_out: out std_logic
            );
end LBDR_input_wire;


architecture behavior of LBDR_input_wire is

begin 

  empty_out <= empty;
  flit_type_out <= flit_type;

  cur_addr_y_out <= cur_addr_y;
  cur_addr_x_out <= cur_addr_x;
  dst_addr_y_out <= dst_addr_y;
  dst_addr_x_out <= dst_addr_x;

  grant_N_out <= grant_N;
  grant_E_out <= grant_E;
  grant_W_out <= grant_W;
  grant_S_out <= grant_S;
  grant_L_out <= grant_L;

end;