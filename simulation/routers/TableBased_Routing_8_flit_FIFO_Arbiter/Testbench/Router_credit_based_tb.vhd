--Copyright (C) 2016 Siavoosh Payandeh Azad
------------------------------------------------------------
-- This file is automatically generated Please do not change!
-- Here are the parameters:
-- 	 network size x:4
-- 	 network size y:4
-- 	 data width:32-- 	 traffic pattern:------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.TB_Package.all;

USE ieee.numeric_std.ALL; 
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

entity tb_router is
    --Pass the filenames to write to for the sent and received file.
	--generic (sent_file,recv_file : string);
end tb_router; 


architecture behavior of tb_router is

--define the router

-- Declaring router component
component router_credit_based is
  --generic (
  --      DATA_WIDTH: integer := 32; 
  --      current_address : integer := 5;
  --      NoC_size: integer := 4
  --  );
    port (
    reset, clk: in std_logic; 

    RX_N, RX_E, RX_W, RX_S, RX_L : in std_logic_vector (31 downto 0); 
    credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;
    valid_in_N, valid_in_E, valid_in_W, valid_in_S, valid_in_L : in std_logic;

    valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L : out std_logic;
    credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L: out std_logic;

    TX_N, TX_E, TX_W, TX_S, TX_L: out std_logic_vector (31 downto 0)
    ); 
end component; 

-- generating bulk signals...

--define the signals of the router
	signal RX_L_5, TX_L_5,RX_N_5, RX_E_5, RX_W_5, RX_S_5,	
		TX_N_5, TX_E_5, TX_W_5, TX_S_5:  std_logic_vector (31 downto 0);

	signal credit_in_N_5, credit_in_E_5, credit_in_W_5, credit_in_S_5, credit_in_L_5, valid_in_N_5, valid_in_E_5, valid_in_W_5, valid_in_S_5, valid_in_L_5,
		valid_out_N_5, valid_out_E_5, valid_out_W_5, valid_out_S_5, valid_out_L_5,
		credit_out_N_5, credit_out_E_5, credit_out_W_5, credit_out_S_5, credit_out_L_5: std_logic;

	signal credit_counter_out_5:  std_logic_vector (2 downto 0);
	signal credit_counter_out_1:  std_logic_vector (2 downto 0);
	signal credit_counter_out_4:  std_logic_vector (2 downto 0);
	signal credit_counter_out_6:  std_logic_vector (2 downto 0);
	signal credit_counter_out_9:  std_logic_vector (2 downto 0);

	--------------
	constant clk_period : time := 10 ns;
	signal reset, not_reset, clk: std_logic :='0';

begin

   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;   
        clk <= '1';
        wait for clk_period/2; 
   end process;

reset <= '1' after 1 ns;


-- instantiating the router
R_5: router_credit_based 
--generic map (DATA_WIDTH => 32, current_address=>5, NoC_size=>4)
PORT MAP (  reset, clk, 

        	RX_N_5, RX_E_5, RX_W_5, RX_S_5, RX_L_5,
        	credit_in_N_5, credit_in_E_5, credit_in_W_5, credit_in_S_5, credit_in_L_5,
        	valid_in_N_5, valid_in_E_5, valid_in_W_5, valid_in_S_5, valid_in_L_5,
        	valid_out_N_5, valid_out_E_5, valid_out_W_5, valid_out_S_5, valid_out_L_5,
        	credit_out_N_5, credit_out_E_5, credit_out_W_5, credit_out_S_5, credit_out_L_5,
        	TX_N_5, TX_E_5, TX_W_5, TX_S_5, TX_L_5); 

not_reset <= not reset; 

-- connecting the packet generators
 
--set up traffic generators
credit_counter_control(clk, credit_out_L_5, valid_in_L_5, credit_counter_out_5);
gen_random_packet("sent.txt",4, 50, 5, 23, 8, 8, 10000 ns, clk, credit_counter_out_5, valid_in_L_5, RX_L_5);

credit_counter_control(clk, credit_out_N_5, valid_in_N_5, credit_counter_out_1);
gen_random_packet("sent.txt",4, 50, 1, 23, 8, 8, 10000 ns, clk, credit_counter_out_1, valid_in_N_5, RX_N_5);

credit_counter_control(clk, credit_out_E_5, valid_in_E_5, credit_counter_out_6);
gen_random_packet("sent.txt",4, 50, 6, 23, 8, 8, 10000 ns, clk, credit_counter_out_6, valid_in_E_5, RX_E_5);

credit_counter_control(clk, credit_out_S_5, valid_in_S_5, credit_counter_out_9);
gen_random_packet("sent.txt",4, 50, 9, 23, 8, 8, 10000 ns, clk, credit_counter_out_9, valid_in_S_5, RX_S_5);

credit_counter_control(clk, credit_out_W_5, valid_in_W_5, credit_counter_out_4);
gen_random_packet("sent.txt",4, 50, 4, 23, 8, 8, 10000 ns, clk, credit_counter_out_4, valid_in_W_5, RX_W_5);



-- connecting the packet receivers
get_packet("received.txt",32, 5, 1, clk, credit_in_N_5, valid_out_N_5, TX_N_5);
get_packet("received.txt",32, 5, 6, clk, credit_in_E_5, valid_out_E_5, TX_E_5);
get_packet("received.txt",32, 5, 9, clk, credit_in_S_5, valid_out_S_5, TX_S_5);
get_packet("received.txt",32, 5, 4, clk, credit_in_W_5, valid_out_W_5, TX_W_5);
get_packet("received.txt",32, 5, 5, clk, credit_in_L_5, valid_out_L_5, TX_L_5);


end;
