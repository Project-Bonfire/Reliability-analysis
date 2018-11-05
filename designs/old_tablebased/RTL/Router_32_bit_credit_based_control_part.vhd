--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
use work.router_pack.all;

entity router_credit_based_control_part is
    generic (
             cur_addr_rst: integer := 5;
             Rxy_rst: integer := 8;             
             Cx_rst: integer := 15;
             NoC_size: integer := 4
            );

       port (
             reset, clk: in std_logic;

             empty_N, empty_E, empty_W, empty_S, empty_L: in std_logic;
             dst_addr_N, dst_addr_E, dst_addr_W, dst_addr_S, dst_addr_L: in std_logic_vector(NoC_size-1 downto 0);
             flit_type_N, flit_type_E, flit_type_W, flit_type_S, flit_type_L: in std_logic_vector(2 downto 0);
             credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;
    
             valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L : out std_logic;
             Xbar_sel_N, Xbar_sel_E, Xbar_sel_W, Xbar_sel_S, Xbar_sel_L: out std_logic_vector (4 downto 0);
             FIFO_N_read_en_E, FIFO_N_read_en_W, FIFO_N_read_en_S, FIFO_N_read_en_L: out std_logic;
             FIFO_E_read_en_N, FIFO_E_read_en_W, FIFO_E_read_en_S, FIFO_E_read_en_L: out std_logic;
             FIFO_W_read_en_N, FIFO_W_read_en_E, FIFO_W_read_en_S, FIFO_W_read_en_L: out std_logic;
             FIFO_S_read_en_N, FIFO_S_read_en_E, FIFO_S_read_en_W, FIFO_S_read_en_L: out std_logic;
             FIFO_L_read_en_N, FIFO_L_read_en_E, FIFO_L_read_en_W, FIFO_L_read_en_S: out std_logic
            ); 
end entity router_credit_based_control_part; 

architecture behavior of router_credit_based_control_part is

 	signal Req_NN, Req_EN, Req_WN, Req_SN, Req_LN: std_logic;
 	signal Req_NE, Req_EE, Req_WE, Req_SE, Req_LE: std_logic;
 	signal Req_NW, Req_EW, Req_WW, Req_SW, Req_LW: std_logic;
 	signal Req_NS, Req_ES, Req_WS, Req_SS, Req_LS: std_logic;
 	signal Req_NL, Req_EL, Req_WL, Req_SL, Req_LL: std_logic;

    -- Grant_XY : Grant signal generated from Arbiter for output X connected to FIFO of input Y
    signal Grant_NE, Grant_NW, Grant_NS, Grant_NL: std_logic; 
    signal Grant_EN, Grant_EW, Grant_ES, Grant_EL: std_logic; 
    signal Grant_WN, Grant_WE, Grant_WS, Grant_WL: std_logic; 
    signal Grant_SN, Grant_SE, Grant_SW, Grant_SL: std_logic; 
    signal Grant_LN, Grant_LE, Grant_LW, Grant_LS: std_logic; 

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

begin

-- Taking grant signals to output, which will serve as read_en inputs for FIFOs

FIFO_E_read_en_N <= Grant_NE;   FIFO_N_read_en_E <= Grant_EN;   FIFO_N_read_en_W <= Grant_WN;
FIFO_W_read_en_N <= Grant_NW;   FIFO_W_read_en_E <= Grant_EW;   FIFO_E_read_en_W <= Grant_WE;
FIFO_S_read_en_N <= Grant_NS;   FIFO_S_read_en_E <= Grant_ES;   FIFO_S_read_en_W <= Grant_WS;
FIFO_L_read_en_N <= Grant_NL;   FIFO_L_read_en_E <= Grant_EL;   FIFO_L_read_en_W <= Grant_WL;

FIFO_N_read_en_S <= Grant_SN;   FIFO_N_read_en_L <= Grant_LN; 
FIFO_E_read_en_S <= Grant_SE;   FIFO_E_read_en_L <= Grant_LE; 
FIFO_W_read_en_S <= Grant_SW;   FIFO_W_read_en_L <= Grant_LW; 
FIFO_L_read_en_S <= Grant_SL;   FIFO_S_read_en_L <= Grant_LS; 

-- all the LBDRs
LBDR_N: LBDR generic map (cur_addr_rst => cur_addr_rst, Rxy_rst => Rxy_rst, Cx_rst => Cx_rst, NoC_size => NoC_size)
       PORT MAP (reset => reset, clk => clk, empty => empty_N,
             flit_type => flit_type_N, dst_addr=> dst_addr_N ,
             grant_N => '0', grant_E =>Grant_EN, grant_W => Grant_WN, grant_S=>Grant_SN, grant_L =>Grant_LN,
             Req_N=> open, Req_E=>Req_NE, Req_W=>Req_NW, Req_S=>Req_NS, Req_L=>Req_NL);

LBDR_E: LBDR generic map (cur_addr_rst => cur_addr_rst, Rxy_rst => Rxy_rst, Cx_rst => Cx_rst, NoC_size => NoC_size)
   PORT MAP (reset =>  reset, clk => clk, empty => empty_E,
             flit_type => flit_type_E, dst_addr=> dst_addr_E ,
             grant_N => Grant_NE, grant_E =>'0', grant_W => Grant_WE, grant_S=>Grant_SE, grant_L =>Grant_LE,
             Req_N=> Req_EN, Req_E=> open, Req_W=>Req_EW, Req_S=>Req_ES, Req_L=>Req_EL);

LBDR_W: LBDR generic map (cur_addr_rst => cur_addr_rst, Rxy_rst => Rxy_rst, Cx_rst => Cx_rst, NoC_size => NoC_size)
   PORT MAP (reset =>  reset, clk => clk, empty => empty_W,
             flit_type => flit_type_W, dst_addr=> dst_addr_W ,
             grant_N => Grant_NW, grant_E =>Grant_EW, grant_W =>'0' ,grant_S=>Grant_SW, grant_L =>Grant_LW,
             Req_N=> Req_WN, Req_E=>Req_WE, Req_W=> open, Req_S=>Req_WS, Req_L=>Req_WL);

LBDR_S: LBDR generic map (cur_addr_rst => cur_addr_rst, Rxy_rst => Rxy_rst, Cx_rst => Cx_rst, NoC_size => NoC_size)
   PORT MAP (reset =>  reset, clk => clk, empty => empty_S,
             flit_type => flit_type_S, dst_addr=> dst_addr_S ,
             grant_N => Grant_NS, grant_E =>Grant_ES, grant_W =>Grant_WS ,grant_S=>'0', grant_L =>Grant_LS,
             Req_N=> Req_SN, Req_E=>Req_SE, Req_W=>Req_SW, Req_S=> open, Req_L=>Req_SL);

LBDR_L: LBDR generic map (cur_addr_rst => cur_addr_rst, Rxy_rst => Rxy_rst, Cx_rst => Cx_rst, NoC_size => NoC_size)
   PORT MAP (reset =>  reset, clk => clk, empty => empty_L,
             flit_type => flit_type_L, dst_addr=> dst_addr_L ,
             grant_N => Grant_NL, grant_E =>Grant_EL, grant_W => Grant_WL,grant_S=>Grant_SL, grant_L =>'0',
             Req_N=> Req_LN, Req_E=>Req_LE, Req_W=>Req_LW, Req_S=>Req_LS, Req_L=> open);

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-- switch allocator
 
allocator_unit: allocator port map ( reset => reset, clk => clk,
            -- flow control
            credit_in_N => credit_in_N, credit_in_E => credit_in_E, credit_in_W => credit_in_W, credit_in_S => credit_in_S, credit_in_L => credit_in_L,

            -- requests from the LBDRS
            req_N_N => '0', req_N_E => Req_NE, req_N_W => Req_NW, req_N_S => Req_NS, req_N_L => Req_NL,
            req_E_N => Req_EN, req_E_E => '0', req_E_W => Req_EW, req_E_S => Req_ES, req_E_L => Req_EL,
            req_W_N => Req_WN, req_W_E => Req_WE, req_W_W => '0', req_W_S => Req_WS, req_W_L => Req_WL,
            req_S_N => Req_SN, req_S_E => Req_SE, req_S_W => Req_SW, req_S_S => '0', req_S_L => Req_SL,
            req_L_N => Req_LN, req_L_E => Req_LE, req_L_W => Req_LW, req_L_S => Req_LS, req_L_L => '0',
            empty_N => empty_N, empty_E => empty_E, empty_w => empty_W, empty_S => empty_S, empty_L => empty_L, 
            valid_N => valid_out_N, valid_E => valid_out_E, valid_W => valid_out_W, valid_S => valid_out_S, valid_L => valid_out_L,
            -- grant_X_Y means the grant for X output port towards Y input port
            -- this means for any X in [N, E, W, S, L] then set grant_X_Y is one hot!
            grant_N_N => open, grant_N_E => Grant_NE, grant_N_W => Grant_NW, grant_N_S => Grant_NS, grant_N_L => Grant_NL,
            grant_E_N => Grant_EN, grant_E_E => open, grant_E_W => Grant_EW, grant_E_S => Grant_ES, grant_E_L => Grant_EL,
            grant_W_N => Grant_WN, grant_W_E => Grant_WE, grant_W_W => open, grant_W_S => Grant_WS, grant_W_L => Grant_WL,
            grant_S_N => Grant_SN, grant_S_E => Grant_SE, grant_S_W => Grant_SW, grant_S_S => open, grant_S_L => Grant_SL,
            grant_L_N => Grant_LN, grant_L_E => Grant_LE, grant_L_W => Grant_LW, grant_L_S => Grant_LS, grant_L_L => open            
            );

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
-- all the Xbar select_signals

Xbar_sel_N <= '0' & Grant_NE & Grant_NW & Grant_NS & Grant_NL;
Xbar_sel_E <= Grant_EN & '0' & Grant_EW & Grant_ES & Grant_EL;
Xbar_sel_W <= Grant_WN & Grant_WE & '0' & Grant_WS & Grant_WL;
Xbar_sel_S <= Grant_SN & Grant_SE & Grant_SW & '0' & Grant_SL;
Xbar_sel_L <= Grant_LN & Grant_LE & Grant_LW & Grant_LS & '0';

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

end architecture behavior;
