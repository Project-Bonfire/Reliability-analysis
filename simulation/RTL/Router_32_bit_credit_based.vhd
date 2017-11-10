--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;

entity router_credit_based is
    generic (
        DATA_WIDTH: integer := 32;
        current_address : integer := 0;
        Cx_rst : integer := 10;
        NoC_size: integer := 4
    );
    port (
    reset, clk: in std_logic;

    Rxy_reconf: in  std_logic_vector(7 downto 0);
    Reconfig : in std_logic;

    RX_N, RX_E, RX_W, RX_S, RX_L : in std_logic_vector (DATA_WIDTH-1 downto 0); 

    credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L: in std_logic;
    valid_in_N, valid_in_E, valid_in_W, valid_in_S, valid_in_L : in std_logic;

    valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L : out std_logic;
    credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L: out std_logic;

    TX_N, TX_E, TX_W, TX_S, TX_L: out std_logic_vector (DATA_WIDTH-1 downto 0)
    ); 
end router_credit_based; 

architecture behavior of router_credit_based is

  COMPONENT FIFO_credit_based   
    generic (
        DATA_WIDTH: integer := 32
    );
    port (  reset: in  std_logic;
            clk: in  std_logic;
            RX: in std_logic_vector(DATA_WIDTH-1 downto 0); 
            valid_in: in std_logic;  
            read_en_N : in std_logic;
            read_en_E : in std_logic;
            read_en_W : in std_logic;
            read_en_S : in std_logic;
            read_en_L : in std_logic;
            credit_out: out std_logic; 
            empty_out: out std_logic; 
            Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
    end COMPONENT;

    COMPONENT router_credit_based_control_part is
        generic (
                 cur_addr_rst: integer := 5;
                 Cx_rst: integer := 15;
                 NoC_size: integer := 4
                );

           port (
                 reset, clk: in std_logic;

                 Rxy_reconf: in  std_logic_vector(7 downto 0);
                 Reconfig : in std_logic;
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
    end COMPONENT; 

    COMPONENT XBAR is
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
        Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
    end COMPONENT;

    signal FIFO_D_out_N, FIFO_D_out_E, FIFO_D_out_W, FIFO_D_out_S, FIFO_D_out_L: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal FIFO_N_read_en_E, FIFO_N_read_en_W, FIFO_N_read_en_S, FIFO_N_read_en_L: std_logic;
    signal FIFO_E_read_en_N, FIFO_E_read_en_W, FIFO_E_read_en_S, FIFO_E_read_en_L: std_logic;
    signal FIFO_W_read_en_N, FIFO_W_read_en_E, FIFO_W_read_en_S, FIFO_W_read_en_L: std_logic;
    signal FIFO_S_read_en_N, FIFO_S_read_en_E, FIFO_S_read_en_W, FIFO_S_read_en_L: std_logic;
    signal FIFO_L_read_en_N, FIFO_L_read_en_E, FIFO_L_read_en_W, FIFO_L_read_en_S: std_logic;
    signal empty_N, empty_E, empty_W, empty_S, empty_L: std_logic; 
    signal Xbar_sel_N, Xbar_sel_E, Xbar_sel_W, Xbar_sel_S, Xbar_sel_L: std_logic_vector(4 downto 0);

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

begin
    

-- all the FIFOs
FIFO_N: FIFO_credit_based 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_N, valid_in => valid_in_N,  
            read_en_N => '0', read_en_E =>FIFO_N_read_en_E, read_en_W =>FIFO_N_read_en_W, read_en_S =>FIFO_N_read_en_S, read_en_L =>FIFO_N_read_en_L, 
            credit_out => credit_out_N, empty_out => empty_N, Data_out => FIFO_D_out_N);

FIFO_E: FIFO_credit_based 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_E, valid_in => valid_in_E,  
            read_en_N => FIFO_E_read_en_N, read_en_E =>'0', read_en_W =>FIFO_E_read_en_W, read_en_S =>FIFO_E_read_en_S, read_en_L =>FIFO_E_read_en_L, 
            credit_out => credit_out_E, empty_out => empty_E, Data_out => FIFO_D_out_E);
    
FIFO_W: FIFO_credit_based 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_W, valid_in => valid_in_W,  
            read_en_N => FIFO_W_read_en_N, read_en_E =>FIFO_W_read_en_E, read_en_W =>'0', read_en_S =>FIFO_W_read_en_S, read_en_L =>FIFO_W_read_en_L, 
            credit_out => credit_out_W, empty_out => empty_W, Data_out => FIFO_D_out_W);

FIFO_S: FIFO_credit_based 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_S, valid_in => valid_in_S,  
            read_en_N => FIFO_S_read_en_N, read_en_E =>FIFO_S_read_en_E, read_en_W =>FIFO_S_read_en_W, read_en_S =>'0', read_en_L =>FIFO_S_read_en_L,  
            credit_out => credit_out_S, empty_out => empty_S, Data_out => FIFO_D_out_S);

FIFO_L: FIFO_credit_based 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, RX => RX_L, valid_in => valid_in_L,  
            read_en_N => FIFO_L_read_en_N, read_en_E =>FIFO_L_read_en_E, read_en_W =>FIFO_L_read_en_W, read_en_S => FIFO_L_read_en_S, read_en_L =>'0',
            credit_out => credit_out_L, empty_out => empty_L, Data_out => FIFO_D_out_L);

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-- The Control Part (5 x LBDRs + Allocator)
CONTROL_PART: router_credit_based_control_part 
    generic map (cur_addr_rst => current_address, Cx_rst => Cx_rst, NoC_size => NoC_size)
       PORT MAP (
                 reset => reset, clk => clk, 

                 Rxy_reconf => Rxy_reconf, 
                 Reconfig => Reconfig, 

                 empty_N => empty_N, empty_E => empty_E, empty_W => empty_W, empty_S => empty_S, empty_L => empty_L, 
                 dst_addr_N => FIFO_D_out_N(DATA_WIDTH-19+NoC_size-1 downto DATA_WIDTH-19), 
                 dst_addr_E => FIFO_D_out_E(DATA_WIDTH-19+NoC_size-1 downto DATA_WIDTH-19),
                 dst_addr_W => FIFO_D_out_W(DATA_WIDTH-19+NoC_size-1 downto DATA_WIDTH-19), 
                 dst_addr_S => FIFO_D_out_S(DATA_WIDTH-19+NoC_size-1 downto DATA_WIDTH-19), 
                 dst_addr_L => FIFO_D_out_L(DATA_WIDTH-19+NoC_size-1 downto DATA_WIDTH-19), 
                 flit_type_N => FIFO_D_out_N(DATA_WIDTH-1 downto DATA_WIDTH-3), 
                 flit_type_E => FIFO_D_out_E(DATA_WIDTH-1 downto DATA_WIDTH-3), 
                 flit_type_W => FIFO_D_out_W(DATA_WIDTH-1 downto DATA_WIDTH-3), 
                 flit_type_S => FIFO_D_out_S(DATA_WIDTH-1 downto DATA_WIDTH-3), 
                 flit_type_L => FIFO_D_out_L(DATA_WIDTH-1 downto DATA_WIDTH-3), 
                 credit_in_N => credit_in_N, credit_in_E => credit_in_E, credit_in_W => credit_in_W, credit_in_S => credit_in_S, credit_in_L => credit_in_L, 

                 valid_out_N => valid_out_N, valid_out_E => valid_out_E, valid_out_W => valid_out_W, valid_out_S => valid_out_S, valid_out_L => valid_out_L, 
                 Xbar_sel_N => Xbar_sel_N, Xbar_sel_E => Xbar_sel_E, Xbar_sel_W => Xbar_sel_W, Xbar_sel_S => Xbar_sel_S, Xbar_sel_L => Xbar_sel_L, 
                 FIFO_N_read_en_E => FIFO_N_read_en_E, FIFO_N_read_en_W => FIFO_N_read_en_W, FIFO_N_read_en_S => FIFO_N_read_en_S, FIFO_N_read_en_L => FIFO_N_read_en_L, 
                 FIFO_E_read_en_N => FIFO_E_read_en_N, FIFO_E_read_en_W => FIFO_E_read_en_W, FIFO_E_read_en_S => FIFO_E_read_en_S, FIFO_E_read_en_L => FIFO_E_read_en_L, 
                 FIFO_W_read_en_N => FIFO_W_read_en_N, FIFO_W_read_en_E => FIFO_W_read_en_E, FIFO_W_read_en_S => FIFO_W_read_en_S, FIFO_W_read_en_L => FIFO_W_read_en_L, 
                 FIFO_S_read_en_N => FIFO_S_read_en_N, FIFO_S_read_en_E => FIFO_S_read_en_E, FIFO_S_read_en_W => FIFO_S_read_en_W, FIFO_S_read_en_L => FIFO_S_read_en_L, 
                 FIFO_L_read_en_N => FIFO_L_read_en_N, FIFO_L_read_en_E => FIFO_L_read_en_E, FIFO_L_read_en_W => FIFO_L_read_en_W, FIFO_L_read_en_S => FIFO_L_read_en_S
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

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


end;
