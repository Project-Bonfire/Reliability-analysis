--Copyright (C) 2016 Siavoosh Payandeh Azad Behrad Niazmand

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.ALL;

entity allocator_input_wire is
    port (
          -- Inputs
          credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in  std_logic;

          req_N_N, req_N_E, req_N_W, req_N_S, req_N_L: in std_logic;
          req_E_N, req_E_E, req_E_W, req_E_S, req_E_L: in std_logic;
          req_W_N, req_W_E, req_W_W, req_W_S, req_W_L: in std_logic;
          req_S_N, req_S_E, req_S_W, req_S_S, req_S_L: in std_logic;
          req_L_N, req_L_E, req_L_W, req_L_S, req_L_L: in std_logic;

          empty_N, empty_E, empty_W, empty_S, empty_L: in std_logic;

          -- Outputs
          credit_in_N_out, credit_in_E_out, credit_in_W_out, credit_in_S_out, credit_in_L_out: out  std_logic;

          req_N_N_out, req_N_E_out, req_N_W_out, req_N_S_out, req_N_L_out: out std_logic;
          req_E_N_out, req_E_E_out, req_E_W_out, req_E_S_out, req_E_L_out: out std_logic;
          req_W_N_out, req_W_E_out, req_W_W_out, req_W_S_out, req_W_L_out: out std_logic;
          req_S_N_out, req_S_E_out, req_S_W_out, req_S_S_out, req_S_L_out: out std_logic;
          req_L_N_out, req_L_E_out, req_L_W_out, req_L_S_out, req_L_L_out: out std_logic;

          empty_N_out, empty_E_out, empty_W_out, empty_S_out, empty_L_out: out std_logic                                          
        );
end allocator_input_wire;


architecture behavior of allocator_input_wire is

begin 
  
  credit_in_N_out <= credit_in_N;
  credit_in_E_out <= credit_in_E;
  credit_in_W_out <= credit_in_W;
  credit_in_S_out <= credit_in_S;
  credit_in_L_out <= credit_in_L;

  req_N_N_out <= req_N_N; req_N_E_out <= req_N_E; req_N_W_out <= req_N_W; req_N_S_out <= req_N_S; req_N_L_out <= req_N_L;
  req_E_N_out <= req_E_N; req_E_E_out <= req_E_E; req_E_W_out <= req_E_W; req_E_S_out <= req_E_S; req_E_L_out <= req_E_L;
  req_W_N_out <= req_W_N; req_W_E_out <= req_W_E; req_W_W_out <= req_W_W; req_W_S_out <= req_W_S; req_W_L_out <= req_W_L;
  req_S_N_out <= req_S_N; req_S_E_out <= req_S_E; req_S_W_out <= req_S_W; req_S_S_out <= req_S_S; req_S_L_out <= req_S_L;
  req_L_N_out <= req_L_N; req_L_E_out <= req_L_E; req_L_W_out <= req_L_W; req_L_S_out <= req_L_S; req_L_L_out <= req_L_L;

  empty_N_out <= empty_N;
  empty_E_out <= empty_E;
  empty_W_out <= empty_W;
  empty_S_out <= empty_S;
  empty_L_out <= empty_L;

end;