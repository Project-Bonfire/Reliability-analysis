--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
use work.router_pack.all;


entity router_credit_based is
    generic (
        DATA_WIDTH: integer := 32;
        current_address : integer := 5;
        Rxy_rst  : integer := 60;
        Cx_rst : integer := 16;
        NoC_size_x: integer := 4
    );
    port (
    reset, clk: in std_logic;
        
    RX_N, RX_E, RX_W, RX_S, RX_L : in std_logic_vector (DATA_WIDTH-1 downto 0);

    credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;
    valid_in_N, valid_in_E, valid_in_W, valid_in_S, valid_in_L : in std_logic;

    valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L : out std_logic;
    credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L: out std_logic;

    TX_N, TX_E, TX_W, TX_S, TX_L: out std_logic_vector (DATA_WIDTH-1 downto 0);

    -- Allocator outputs 
    Grant_NN_out, Grant_NE_out, Grant_NW_out, Grant_NS_out, Grant_NL_out: out std_logic;
    Grant_EN_out, Grant_EE_out, Grant_EW_out, Grant_ES_out, Grant_EL_out: out std_logic;
    Grant_WN_out, Grant_WE_out, Grant_WW_out, Grant_WS_out, Grant_WL_out: out std_logic;
    Grant_SN_out, Grant_SE_out, Grant_SW_out, Grant_SS_out, Grant_SL_out: out std_logic;
    Grant_LN_out, Grant_LE_out, Grant_LW_out, Grant_LS_out, Grant_LL_out: out std_logic;
    Xbar_sel_N_out, Xbar_sel_E_out, Xbar_sel_W_out, Xbar_sel_S_out, Xbar_sel_L_out: out std_logic_vector(4 downto 0);

    -- LBDR outputs
    Req_NN_out, Req_EN_out, Req_WN_out, Req_SN_out, Req_LN_out: out std_logic;
    Req_NE_out, Req_EE_out, Req_WE_out, Req_SE_out, Req_LE_out: out std_logic;
    Req_NW_out, Req_EW_out, Req_WW_out, Req_SW_out, Req_LW_out: out std_logic;
    Req_NS_out, Req_ES_out, Req_WS_out, Req_SS_out, Req_LS_out: out std_logic;
    Req_NL_out, Req_EL_out, Req_WL_out, Req_SL_out, Req_LL_out: out std_logic;

    -- FIFO outputs
    empty_N_out, empty_E_out, empty_W_out, empty_S_out, empty_L_out: out std_logic;

    read_pointer_out_N_out, write_pointer_out_N_out: out std_logic_vector(3 downto 0);
    read_pointer_out_E_out, write_pointer_out_E_out: out std_logic_vector(3 downto 0);
    read_pointer_out_W_out, write_pointer_out_W_out: out std_logic_vector(3 downto 0);
    read_pointer_out_S_out, write_pointer_out_S_out: out std_logic_vector(3 downto 0);
    read_pointer_out_L_out, write_pointer_out_L_out: out std_logic_vector(3 downto 0);

    write_en_out_N_out: out std_logic;
    write_en_out_E_out: out std_logic;
    write_en_out_W_out: out std_logic;
    write_en_out_S_out: out std_logic;
    write_en_out_L_out: out std_logic
    );
end router_credit_based;



architecture behavior of router_credit_based is

    signal FIFO_D_out_N, FIFO_D_out_E, FIFO_D_out_W, FIFO_D_out_S, FIFO_D_out_L: std_logic_vector(DATA_WIDTH-1 downto 0);

    -- Grant_XY : Grant signal generated from Arbiter for output X connected to FIFO of input Y

    signal cur_addr_y_N, cur_addr_x_N: std_logic_vector(6 downto 0);
    signal dst_addr_y_N, dst_addr_x_N: std_logic_vector(6 downto 0);
    signal cur_addr_y_E, cur_addr_x_E: std_logic_vector(6 downto 0);
    signal dst_addr_y_E, dst_addr_x_E: std_logic_vector(6 downto 0);
    signal cur_addr_y_W, cur_addr_x_W: std_logic_vector(6 downto 0);
    signal dst_addr_y_W, dst_addr_x_W: std_logic_vector(6 downto 0);
    signal cur_addr_y_S, cur_addr_x_S: std_logic_vector(6 downto 0);
    signal dst_addr_y_S, dst_addr_x_S: std_logic_vector(6 downto 0);
    signal cur_addr_y_L, cur_addr_x_L: std_logic_vector(6 downto 0);
    signal dst_addr_y_L, dst_addr_x_L: std_logic_vector(6 downto 0);

    signal Grant_NN, Grant_NE, Grant_NW, Grant_NS, Grant_NL: std_logic;
    signal Grant_EN, Grant_EE, Grant_EW, Grant_ES, Grant_EL: std_logic;
    signal Grant_WN, Grant_WE, Grant_WW, Grant_WS, Grant_WL: std_logic;
    signal Grant_SN, Grant_SE, Grant_SW, Grant_SS, Grant_SL: std_logic;
    signal Grant_LN, Grant_LE, Grant_LW, Grant_LS, Grant_LL: std_logic;

    signal Req_NN, Req_EN, Req_WN, Req_SN, Req_LN: std_logic;
    signal Req_NE, Req_EE, Req_WE, Req_SE, Req_LE: std_logic;
    signal Req_NW, Req_EW, Req_WW, Req_SW, Req_LW: std_logic;
    signal Req_NS, Req_ES, Req_WS, Req_SS, Req_LS: std_logic;
    signal Req_NL, Req_EL, Req_WL, Req_SL, Req_LL: std_logic;

    signal empty_N, empty_E, empty_W, empty_S, empty_L: std_logic; 

    signal flit_type_N, flit_type_E, flit_type_W, flit_type_S, flit_type_L: std_logic_vector(2 downto 0);

    signal Xbar_sel_N, Xbar_sel_E, Xbar_sel_W, Xbar_sel_S, Xbar_sel_L: std_logic_vector(4 downto 0);

    -- We add these wires (in form of modules) for injecting faults on inputs of router components

    component allocator_input_wire is
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
    end component;

    component LBDR_input_wire is
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
    end component;


    signal credit_in_N_out_sig, credit_in_E_out_sig, credit_in_W_out_sig, credit_in_S_out_sig, credit_in_L_out_sig: std_logic;

    signal req_N_N_out_sig, req_N_E_out_sig, req_N_W_out_sig, req_N_S_out_sig, req_N_L_out_sig: std_logic;
    signal req_E_N_out_sig, req_E_E_out_sig, req_E_W_out_sig, req_E_S_out_sig, req_E_L_out_sig: std_logic;
    signal req_W_N_out_sig, req_W_E_out_sig, req_W_W_out_sig, req_W_S_out_sig, req_W_L_out_sig: std_logic;
    signal req_S_N_out_sig, req_S_E_out_sig, req_S_W_out_sig, req_S_S_out_sig, req_S_L_out_sig: std_logic;
    signal req_L_N_out_sig, req_L_E_out_sig, req_L_W_out_sig, req_L_S_out_sig, req_L_L_out_sig: std_logic;

    signal empty_N_out_sig, empty_E_out_sig, empty_W_out_sig, empty_S_out_sig, empty_L_out_sig: std_logic;                             
    signal empty_N_out_sig_arbiter, empty_E_out_sig_arbiter, empty_W_out_sig_arbiter, empty_S_out_sig_arbiter, empty_L_out_sig_arbiter: std_logic;                             

    signal flit_type_N_out_sig, flit_type_E_out_sig, flit_type_W_out_sig, flit_type_S_out_sig, flit_type_L_out_sig: std_logic_vector(2 downto 0);
    
    signal cur_addr_y_N_out_sig, cur_addr_x_N_out_sig: std_logic_vector(6 downto 0);
    signal dst_addr_y_N_out_sig, dst_addr_x_N_out_sig: std_logic_vector(6 downto 0);
    signal cur_addr_y_E_out_sig, cur_addr_x_E_out_sig: std_logic_vector(6 downto 0);
    signal dst_addr_y_E_out_sig, dst_addr_x_E_out_sig: std_logic_vector(6 downto 0);
    signal cur_addr_y_W_out_sig, cur_addr_x_W_out_sig: std_logic_vector(6 downto 0);
    signal dst_addr_y_W_out_sig, dst_addr_x_W_out_sig: std_logic_vector(6 downto 0);
    signal cur_addr_y_S_out_sig, cur_addr_x_S_out_sig: std_logic_vector(6 downto 0);
    signal dst_addr_y_S_out_sig, dst_addr_x_S_out_sig: std_logic_vector(6 downto 0);
    signal cur_addr_y_L_out_sig, cur_addr_x_L_out_sig: std_logic_vector(6 downto 0);
    signal dst_addr_y_L_out_sig, dst_addr_x_L_out_sig: std_logic_vector(6 downto 0);
    
    signal grant_NN_out_sig, grant_EN_out_sig, grant_WN_out_sig, grant_SN_out_sig, grant_LN_out_sig: std_logic;                      
    signal grant_NE_out_sig, grant_EE_out_sig, grant_WE_out_sig, grant_SE_out_sig, grant_LE_out_sig: std_logic;                      
    signal grant_NW_out_sig, grant_EW_out_sig, grant_WW_out_sig, grant_SW_out_sig, grant_LW_out_sig: std_logic;                      
    signal grant_NS_out_sig, grant_ES_out_sig, grant_WS_out_sig, grant_SS_out_sig, grant_LS_out_sig: std_logic;                      
    signal grant_NL_out_sig, grant_EL_out_sig, grant_WL_out_sig, grant_SL_out_sig, grant_LL_out_sig: std_logic;                      


begin

    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------

    -- all the FIFOs
    FIFO_N: FIFO_credit_based
        generic map ( DATA_WIDTH => DATA_WIDTH)
        port map ( reset => reset, clk => clk, RX => RX_N, valid_in => valid_in_N,
                read_en_N => '0', read_en_E =>Grant_EN, read_en_W =>Grant_WN, read_en_S =>Grant_SN, read_en_L =>Grant_LN,
                credit_out => credit_out_N, empty_out => empty_N, Data_out => FIFO_D_out_N,
                read_pointer_out_out=>read_pointer_out_N_out, write_pointer_out_out=>write_pointer_out_N_out,
                write_en_out_out=>write_en_out_N_out);

    FIFO_E: FIFO_credit_based
        generic map ( DATA_WIDTH => DATA_WIDTH)
        port map ( reset => reset, clk => clk, RX => RX_E, valid_in => valid_in_E,
                read_en_N => Grant_NE, read_en_E =>'0', read_en_W =>Grant_WE, read_en_S =>Grant_SE, read_en_L =>Grant_LE,
                credit_out => credit_out_E, empty_out => empty_E, Data_out => FIFO_D_out_E,
                read_pointer_out_out=>read_pointer_out_E_out, write_pointer_out_out=>write_pointer_out_E_out,
                write_en_out_out=>write_en_out_E_out);

    FIFO_W: FIFO_credit_based
        generic map ( DATA_WIDTH => DATA_WIDTH)
        port map ( reset => reset, clk => clk, RX => RX_W, valid_in => valid_in_W,
                read_en_N => Grant_NW, read_en_E =>Grant_EW, read_en_W =>'0', read_en_S =>Grant_SW, read_en_L =>Grant_LW,
                credit_out => credit_out_W, empty_out => empty_W, Data_out => FIFO_D_out_W,
                read_pointer_out_out=>read_pointer_out_W_out, write_pointer_out_out=>write_pointer_out_W_out,
                write_en_out_out=>write_en_out_W_out);

    FIFO_S: FIFO_credit_based
        generic map ( DATA_WIDTH => DATA_WIDTH)
        port map ( reset => reset, clk => clk, RX => RX_S, valid_in => valid_in_S,
                read_en_N => Grant_NS, read_en_E =>Grant_ES, read_en_W =>Grant_WS, read_en_S =>'0', read_en_L =>Grant_LS,
                credit_out => credit_out_S, empty_out => empty_S, Data_out => FIFO_D_out_S,
                read_pointer_out_out=>read_pointer_out_S_out, write_pointer_out_out=>write_pointer_out_S_out,
                write_en_out_out=>write_en_out_S_out);

    FIFO_L: FIFO_credit_based
        generic map ( DATA_WIDTH => DATA_WIDTH)
        port map ( reset => reset, clk => clk, RX => RX_L, valid_in => valid_in_L,
                read_en_N => Grant_NL, read_en_E =>Grant_EL, read_en_W =>Grant_WL, read_en_S => Grant_SL, read_en_L =>'0',
                credit_out => credit_out_L, empty_out => empty_L, Data_out => FIFO_D_out_L,
                read_pointer_out_out=>read_pointer_out_L_out, write_pointer_out_out=>write_pointer_out_L_out,
                write_en_out_out=>write_en_out_L_out);
    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------


    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------

    -- The Control Part (5 x LBDRs + Allocator)
    --CONTROL_PART: router_credit_based_control_part 
    --    generic map (cur_addr_rst => current_address, Rxy_rst => Rxy_rst, Cx_rst => Cx_rst, NoC_size => NoC_size)
    --       PORT MAP (
    --                 reset => reset, clk => clk, 

    --                 empty_N => empty_N, empty_E => empty_E, empty_W => empty_W, empty_S => empty_S, empty_L => empty_L, 
    --                 dst_addr_N => FIFO_D_out_N(NoC_size downto 1), 
    --                 dst_addr_E => FIFO_D_out_E(NoC_size downto 1),
    --                 dst_addr_W => FIFO_D_out_W(NoC_size downto 1), 
    --                 dst_addr_S => FIFO_D_out_S(NoC_size downto 1), 
    --                 dst_addr_L => FIFO_D_out_L(NoC_size downto 1), 
    --                 flit_type_N => FIFO_D_out_N(DATA_WIDTH-1 downto DATA_WIDTH-3), 
    --                 flit_type_E => FIFO_D_out_E(DATA_WIDTH-1 downto DATA_WIDTH-3), 
    --                 flit_type_W => FIFO_D_out_W(DATA_WIDTH-1 downto DATA_WIDTH-3), 
    --                 flit_type_S => FIFO_D_out_S(DATA_WIDTH-1 downto DATA_WIDTH-3), 
    --                 flit_type_L => FIFO_D_out_L(DATA_WIDTH-1 downto DATA_WIDTH-3), 
    --                 credit_in_N => credit_in_N, credit_in_E => credit_in_E, credit_in_W => credit_in_W, credit_in_S => credit_in_S, credit_in_L => credit_in_L, 

    --                 valid_out_N => valid_out_N, valid_out_E => valid_out_E, valid_out_W => valid_out_W, valid_out_S => valid_out_S, valid_out_L => valid_out_L, 
    --                 Xbar_sel_N => Xbar_sel_N, Xbar_sel_E => Xbar_sel_E, Xbar_sel_W => Xbar_sel_W, Xbar_sel_S => Xbar_sel_S, Xbar_sel_L => Xbar_sel_L, 
    --                 FIFO_N_read_en_E => FIFO_N_read_en_E, FIFO_N_read_en_W => FIFO_N_read_en_W, FIFO_N_read_en_S => FIFO_N_read_en_S, FIFO_N_read_en_L => FIFO_N_read_en_L, 
    --                 FIFO_E_read_en_N => FIFO_E_read_en_N, FIFO_E_read_en_W => FIFO_E_read_en_W, FIFO_E_read_en_S => FIFO_E_read_en_S, FIFO_E_read_en_L => FIFO_E_read_en_L, 
    --                 FIFO_W_read_en_N => FIFO_W_read_en_N, FIFO_W_read_en_E => FIFO_W_read_en_E, FIFO_W_read_en_S => FIFO_W_read_en_S, FIFO_W_read_en_L => FIFO_W_read_en_L, 
    --                 FIFO_S_read_en_N => FIFO_S_read_en_N, FIFO_S_read_en_E => FIFO_S_read_en_E, FIFO_S_read_en_W => FIFO_S_read_en_W, FIFO_S_read_en_L => FIFO_S_read_en_L, 
    --                 FIFO_L_read_en_N => FIFO_L_read_en_N, FIFO_L_read_en_E => FIFO_L_read_en_E, FIFO_L_read_en_W => FIFO_L_read_en_W, FIFO_L_read_en_S => FIFO_L_read_en_S
    --                );

    cur_addr_y_N <= std_logic_vector(to_unsigned(current_address / NoC_size_x,7));
    cur_addr_x_N <= std_logic_vector(to_unsigned(current_address mod NoC_size_x,7));
    dst_addr_y_N <= FIFO_D_out_N(14 downto 8);
    dst_addr_x_N <= FIFO_D_out_N(7 downto 1);

    cur_addr_y_E <= std_logic_vector(to_unsigned(current_address / NoC_size_x,7));
    cur_addr_x_E <= std_logic_vector(to_unsigned(current_address mod NoC_size_x,7));
    dst_addr_y_E <= FIFO_D_out_E(14 downto 8);
    dst_addr_x_E <= FIFO_D_out_E(7 downto 1);

    cur_addr_y_W <= std_logic_vector(to_unsigned(current_address / NoC_size_x,7));
    cur_addr_x_W <= std_logic_vector(to_unsigned(current_address mod NoC_size_x,7));
    dst_addr_y_W <= FIFO_D_out_W(14 downto 8);
    dst_addr_x_W <= FIFO_D_out_W(7 downto 1);

    cur_addr_y_S <= std_logic_vector(to_unsigned(current_address / NoC_size_x,7));
    cur_addr_x_S <= std_logic_vector(to_unsigned(current_address mod NoC_size_x,7));
    dst_addr_y_S <= FIFO_D_out_S(14 downto 8);
    dst_addr_x_S <= FIFO_D_out_S(7 downto 1);

    cur_addr_y_L <= std_logic_vector(to_unsigned(current_address / NoC_size_x,7));
    cur_addr_x_L <= std_logic_vector(to_unsigned(current_address mod NoC_size_x,7));
    dst_addr_y_L <= FIFO_D_out_L(14 downto 8);
    dst_addr_x_L <= FIFO_D_out_L(7 downto 1);

    flit_type_N <= FIFO_D_out_N(DATA_WIDTH-1 downto DATA_WIDTH-3);
    flit_type_E <= FIFO_D_out_E(DATA_WIDTH-1 downto DATA_WIDTH-3);
    flit_type_W <= FIFO_D_out_W(DATA_WIDTH-1 downto DATA_WIDTH-3);
    flit_type_S <= FIFO_D_out_S(DATA_WIDTH-1 downto DATA_WIDTH-3);
    flit_type_L <= FIFO_D_out_L(DATA_WIDTH-1 downto DATA_WIDTH-3);

    LBDR_N_inputs: LBDR_input_wire port map (
            empty_N,
            flit_type_N,
            cur_addr_y_N, 
            cur_addr_x_N, 
            dst_addr_y_N, 
            dst_addr_x_N, 
            grant_NN, grant_EN, grant_WN, grant_SN, grant_LN, 

            empty_N_out_sig,
            flit_type_N_out_sig,
            cur_addr_y_N_out_sig, cur_addr_x_N_out_sig,
            dst_addr_y_N_out_sig, dst_addr_x_N_out_sig,
            grant_NN_out_sig, grant_EN_out_sig, grant_WN_out_sig, grant_SN_out_sig, grant_LN_out_sig                       
        );

    LBDR_E_inputs: LBDR_input_wire port map (
            empty_E,
            flit_type_E,
            cur_addr_y_E, 
            cur_addr_x_E, 
            dst_addr_y_E, 
            dst_addr_x_E, 
            grant_NE, grant_EE, grant_WE, grant_SE, grant_LE, 

            empty_E_out_sig,
            flit_type_E_out_sig,
            cur_addr_y_E_out_sig, cur_addr_x_E_out_sig,
            dst_addr_y_E_out_sig, dst_addr_x_E_out_sig,
            grant_NE_out_sig, grant_EE_out_sig, grant_WE_out_sig, grant_SE_out_sig, grant_LE_out_sig                       
        );

    LBDR_W_inputs: LBDR_input_wire port map (
            empty_W,
            flit_type_W,
            cur_addr_y_W, 
            cur_addr_x_W, 
            dst_addr_y_W, 
            dst_addr_x_W, 
            grant_NW, grant_EW, grant_WW, grant_SW, grant_LW, 

            empty_W_out_sig,
            flit_type_W_out_sig,
            cur_addr_y_W_out_sig, cur_addr_x_W_out_sig,
            dst_addr_y_W_out_sig, dst_addr_x_W_out_sig,
            grant_NW_out_sig, grant_EW_out_sig, grant_WW_out_sig, grant_SW_out_sig, grant_LW_out_sig                       
        );

    LBDR_S_inputs: LBDR_input_wire port map (
            empty_S,
            flit_type_S,
            cur_addr_y_S, 
            cur_addr_x_S, 
            dst_addr_y_S, 
            dst_addr_x_S, 
            grant_NS, grant_ES, grant_WS, grant_SS, grant_LS, 

            empty_S_out_sig,
            flit_type_S_out_sig,
            cur_addr_y_S_out_sig, cur_addr_x_S_out_sig,
            dst_addr_y_S_out_sig, dst_addr_x_S_out_sig,
            grant_NS_out_sig, grant_ES_out_sig, grant_WS_out_sig, grant_SS_out_sig, grant_LS_out_sig                       
        );

    LBDR_L_inputs: LBDR_input_wire port map (
            empty_L,
            flit_type_L,
            cur_addr_y_N, 
            cur_addr_x_N, 
            dst_addr_y_N, 
            dst_addr_x_N, 
            grant_NL, grant_EL, grant_WL, grant_SL, grant_LL, 

            empty_L_out_sig,
            flit_type_L_out_sig,
            cur_addr_y_L_out_sig, cur_addr_x_L_out_sig,
            dst_addr_y_L_out_sig, dst_addr_x_L_out_sig,
            grant_NL_out_sig, grant_EL_out_sig, grant_WL_out_sig, grant_SL_out_sig, grant_LL_out_sig                       
        );

    -- all the LBDRs
    LBDR_N: LBDR generic map (Rxy_rst => Rxy_rst, Cx_rst => Cx_rst)
           PORT MAP (reset => reset, clk => clk, empty => empty_N_out_sig,
                 flit_type => flit_type_N_out_sig,
                 cur_addr_y => cur_addr_y_N_out_sig, 
                 cur_addr_x => cur_addr_x_N_out_sig, 
                 dst_addr_y => dst_addr_y_N_out_sig, 
                 dst_addr_x => dst_addr_x_N_out_sig, 
                 grant_N => '0', grant_E =>grant_EN_out_sig, grant_W => Grant_WN_out_sig, grant_S=>Grant_SN_out_sig, grant_L =>Grant_LN_out_sig,
                 
                 Req_N=> Req_NN, Req_E=>Req_NE, Req_W=>Req_NW, Req_S=>Req_NS, Req_L=>Req_NL
                 );

    LBDR_E: LBDR generic map (Rxy_rst => Rxy_rst, Cx_rst => Cx_rst)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_E_out_sig,
                 flit_type => flit_type_E_out_sig, 
                 cur_addr_y => cur_addr_y_E_out_sig, 
                 cur_addr_x => cur_addr_x_E_out_sig, 
                 dst_addr_y => dst_addr_y_E_out_sig, 
                 dst_addr_x => dst_addr_x_E_out_sig, 
                 grant_N => Grant_NE_out_sig, grant_E =>'0', grant_W => Grant_WE_out_sig, grant_S=>Grant_SE_out_sig, grant_L =>Grant_LE_out_sig,
                 
                 Req_N=> Req_EN, Req_E=>Req_EE, Req_W=>Req_EW, Req_S=>Req_ES, Req_L=>Req_EL
                 );

    LBDR_W: LBDR generic map (Rxy_rst => Rxy_rst, Cx_rst => Cx_rst)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_W_out_sig,
                 flit_type => flit_type_W_out_sig,
                 cur_addr_y => cur_addr_y_W_out_sig, 
                 cur_addr_x => cur_addr_x_W_out_sig, 
                 dst_addr_y => dst_addr_y_W_out_sig, 
                 dst_addr_x => dst_addr_x_W_out_sig, 
                 grant_N => Grant_NW_out_sig, grant_E =>Grant_EW_out_sig, grant_W =>'0' ,grant_S=>Grant_SW_out_sig, grant_L =>Grant_LW_out_sig,

                 Req_N=> Req_WN, Req_E=>Req_WE, Req_W=>Req_WW, Req_S=>Req_WS, Req_L=>Req_WL
                 );

    LBDR_S: LBDR generic map (Rxy_rst => Rxy_rst, Cx_rst => Cx_rst)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_S_out_sig,
                 flit_type => flit_type_S_out_sig,
                 cur_addr_y => cur_addr_y_S_out_sig, 
                 cur_addr_x => cur_addr_x_S_out_sig, 
                 dst_addr_y => dst_addr_y_S_out_sig, 
                 dst_addr_x => dst_addr_x_S_out_sig, 
                 grant_N => Grant_NS_out_sig, grant_E =>Grant_ES_out_sig, grant_W =>Grant_WS_out_sig ,grant_S=>'0', grant_L =>Grant_LS_out_sig,
                 
                 Req_N=> Req_SN, Req_E=>Req_SE, Req_W=>Req_SW, Req_S=>Req_SS, Req_L=>Req_SL
                 );

    LBDR_L: LBDR generic map (Rxy_rst => Rxy_rst, Cx_rst => Cx_rst)
       PORT MAP (reset =>  reset, clk => clk, empty => empty_L_out_sig,
                 flit_type => flit_type_L_out_sig,
                 cur_addr_y => cur_addr_y_L_out_sig, 
                 cur_addr_x => cur_addr_x_L_out_sig, 
                 dst_addr_y => dst_addr_y_L_out_sig, 
                 dst_addr_x => dst_addr_x_L_out_sig, 
                 grant_N => Grant_NL_out_sig, grant_E =>Grant_EL_out_sig, grant_W => Grant_WL_out_sig,grant_S=>Grant_SL_out_sig, grant_L =>'0',
                 
                 Req_N=> Req_LN, Req_E=>Req_LE, Req_W=>Req_LW, Req_S=>Req_LS, Req_L=>Req_LL
                 );


    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------

    -- switch allocator (Arbiter)
    allocator_inputs: allocator_input_wire port map (
            -- flow control
            credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L,

            req_NN, req_NE, req_NW, req_NS, req_NL, 
            req_EN, req_EE, req_EW, req_ES, req_EL, 
            req_WN, req_WE, req_WW, req_WS, req_WL, 
            req_SN, req_SE, req_SW, req_SS, req_SL, 
            req_LN, req_LE, req_LW, req_LS, req_LL, 

            empty_N, empty_E, empty_W, empty_S, empty_L, 

            credit_in_N_out_sig, credit_in_E_out_sig, credit_in_W_out_sig, credit_in_S_out_sig, credit_in_L_out_sig, 

            req_N_N_out_sig, req_N_E_out_sig, req_N_W_out_sig, req_N_S_out_sig, req_N_L_out_sig, 
            req_E_N_out_sig, req_E_E_out_sig, req_E_W_out_sig, req_E_S_out_sig, req_E_L_out_sig, 
            req_W_N_out_sig, req_W_E_out_sig, req_W_W_out_sig, req_W_S_out_sig, req_W_L_out_sig, 
            req_S_N_out_sig, req_S_E_out_sig, req_S_W_out_sig, req_S_S_out_sig, req_S_L_out_sig, 
            req_L_N_out_sig, req_L_E_out_sig, req_L_W_out_sig, req_L_S_out_sig, req_L_L_out_sig, 

            empty_N_out_sig_arbiter, empty_E_out_sig_arbiter, empty_W_out_sig_arbiter, empty_S_out_sig_arbiter, empty_L_out_sig_arbiter                       
            );

     
    allocator_unit: allocator port map ( reset => reset, clk => clk,
                -- flow control
                credit_in_N => credit_in_N_out_sig, credit_in_E => credit_in_E_out_sig, credit_in_W => credit_in_W_out_sig, credit_in_S => credit_in_S_out_sig, credit_in_L => credit_in_L_out_sig,

                -- requests from the LBDRS
                req_N_N => '0',             req_N_E => Req_N_E_out_sig, req_N_W => Req_N_W_out_sig, req_N_S => Req_N_S_out_sig, req_N_L => Req_N_L_out_sig,
                req_E_N => Req_E_N_out_sig, req_E_E => '0',             req_E_W => Req_E_W_out_sig, req_E_S => Req_E_S_out_sig, req_E_L => Req_E_L_out_sig,
                req_W_N => Req_W_N_out_sig, req_W_E => Req_W_E_out_sig, req_W_W => '0',             req_W_S => Req_W_S_out_sig, req_W_L => Req_W_L_out_sig,
                req_S_N => Req_S_N_out_sig, req_S_E => Req_S_E_out_sig, req_S_W => Req_S_W_out_sig, req_S_S => '0',             req_S_L => Req_S_L_out_sig,
                req_L_N => Req_L_N_out_sig, req_L_E => Req_L_E_out_sig, req_L_W => Req_L_W_out_sig, req_L_S => Req_L_S_out_sig, req_L_L => '0',

                empty_N => empty_N_out_sig_arbiter, empty_E => empty_E_out_sig_arbiter, empty_w => empty_W_out_sig_arbiter, empty_S => empty_S_out_sig_arbiter, empty_L => empty_L_out_sig_arbiter, 
                
                valid_N => valid_out_N, valid_E => valid_out_E, valid_W => valid_out_W, valid_S => valid_out_S, valid_L => valid_out_L,
                -- grant_X_Y means the grant for X output port towards Y input port
                -- this means for any X in [N, E, W, S, L] then set grant_X_Y is one hot!
                grant_N_N => open, grant_N_E => Grant_NE, grant_N_W => Grant_NW, grant_N_S => Grant_NS, grant_N_L => Grant_NL,
                grant_E_N => Grant_EN, grant_E_E => open, grant_E_W => Grant_EW, grant_E_S => Grant_ES, grant_E_L => Grant_EL,
                grant_W_N => Grant_WN, grant_W_E => Grant_WE, grant_W_W => open, grant_W_S => Grant_WS, grant_W_L => Grant_WL,
                grant_S_N => Grant_SN, grant_S_E => Grant_SE, grant_S_W => Grant_SW, grant_S_S => open, grant_S_L => Grant_SL,
                grant_L_N => Grant_LN, grant_L_E => Grant_LE, grant_L_W => Grant_LW, grant_L_S => Grant_LS, grant_L_L => open, 

                Xbar_sel_N => Xbar_sel_N, Xbar_sel_E => Xbar_sel_E, Xbar_sel_W => Xbar_sel_W, Xbar_sel_S => Xbar_sel_S, Xbar_sel_L => Xbar_sel_L         
                );


    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------


     -- all the Xbars
    XBAR_N: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
       PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
            sel => Xbar_sel_N,  Data_out=> TX_N);
    XBAR_E: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
       PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
            sel => Xbar_sel_E,  Data_out=> TX_E);
    XBAR_W: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
       PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
            sel => Xbar_sel_W,  Data_out=> TX_W);
    XBAR_S: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
       PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
            sel => Xbar_sel_S,  Data_out=> TX_S);
    XBAR_L: XBAR generic map (DATA_WIDTH  => DATA_WIDTH)
       PORT MAP (North_in => FIFO_D_out_N, East_in => FIFO_D_out_E, West_in => FIFO_D_out_W, South_in => FIFO_D_out_S, Local_in => FIFO_D_out_L,
            sel => Xbar_sel_L,  Data_out=> TX_L);


    --------------------------------------------
        
        Grant_NN_out<=Grant_NN; 
        Grant_NE_out<=Grant_NE; 
        Grant_NW_out<=Grant_NW; 
        Grant_NS_out<=Grant_NS; 
        Grant_NL_out<=Grant_NL;
        
        Grant_EN_out<=Grant_EN; 
        Grant_EE_out<=Grant_EE; 
        Grant_EW_out<=Grant_EW; 
        Grant_ES_out<=Grant_ES; 
        Grant_EL_out<=Grant_EL;
        
        Grant_WN_out<=Grant_WN; 
        Grant_WE_out<=Grant_WE; 
        Grant_WW_out<=Grant_WW; 
        Grant_WS_out<=Grant_WS; 
        Grant_WL_out<=Grant_WL;
        
        Grant_SN_out<=Grant_SN; 
        Grant_SE_out<=Grant_SE; 
        Grant_SW_out<=Grant_SW; 
        Grant_SS_out<=Grant_SS; 
        Grant_SL_out<=Grant_SL;
        
        Grant_LN_out<=Grant_LN; 
        Grant_LE_out<=Grant_LE; 
        Grant_LW_out<=Grant_LW; 
        Grant_LS_out<=Grant_LS; 
        Grant_LL_out<=Grant_LL;
        
        Xbar_sel_N_out <= Xbar_sel_N; 
        Xbar_sel_E_out <= Xbar_sel_E; 
        Xbar_sel_W_out <= Xbar_sel_W; 
        Xbar_sel_S_out <= Xbar_sel_S; 
        Xbar_sel_L_out <= Xbar_sel_L;
    --------------------------------------------
    Req_NN_out<= Req_NN; 
    Req_EN_out<= Req_EN; 
    Req_WN_out<= Req_WN; 
    Req_SN_out<= Req_SN; 
    Req_LN_out<= Req_LN;

    Req_NE_out<= Req_NE; 
    Req_EE_out<= Req_EE; 
    Req_WE_out<= Req_WE; 
    Req_SE_out<= Req_SE; 
    Req_LE_out<= Req_LE;

    Req_NW_out<= Req_NW; 
    Req_EW_out<= Req_EW; 
    Req_WW_out<= Req_WW; 
    Req_SW_out<= Req_SW; 
    Req_LW_out<= Req_LW;

    Req_NS_out<= Req_NS; 
    Req_ES_out<= Req_ES; 
    Req_WS_out<= Req_WS; 
    Req_SS_out<= Req_SS; 
    Req_LS_out<= Req_LS;

    Req_NL_out<= Req_NL; 
    Req_EL_out<= Req_EL; 
    Req_WL_out<= Req_WL; 
    Req_SL_out<= Req_SL; 
    Req_LL_out<= Req_LL;
    --------------------------------------------

    empty_N_out <= empty_N;
    empty_E_out <= empty_E;
    empty_W_out <= empty_W;
    empty_S_out <= empty_S;
    empty_L_out <= empty_L;

end;
