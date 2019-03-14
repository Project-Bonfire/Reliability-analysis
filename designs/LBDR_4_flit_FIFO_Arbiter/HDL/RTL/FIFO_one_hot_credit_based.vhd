--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO_credit_based is
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
            Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0);

            read_pointer_out_out, write_pointer_out_out: out std_logic_vector(3 downto 0);
            write_en_out_out: out std_logic
    );
end FIFO_credit_based;

architecture behavior of FIFO_credit_based is

   signal write_en: std_logic;
   signal read_pointer, write_pointer: std_logic_vector(3 downto 0);

  signal valid_in_out_sig  : std_logic;
  signal read_en_N_out_sig : std_logic;
  signal read_en_E_out_sig : std_logic;
  signal read_en_W_out_sig : std_logic;
  signal read_en_S_out_sig : std_logic;
  signal read_en_L_out_sig : std_logic;

  signal write_en_out_sig:  std_logic;
  signal RX_out_sig :  std_logic_vector(DATA_WIDTH-1 downto 0);
  signal read_pointer_out_sig, write_pointer_out_sig: std_logic_vector(3 downto 0);


  component FIFO_control_part_input_wire is
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
  end component;

   component FIFO_control is
       port (  reset: in  std_logic;
               clk: in  std_logic;

               valid_in: in std_logic;
               read_en_N : in std_logic;
               read_en_E : in std_logic;
               read_en_W : in std_logic;
               read_en_S : in std_logic;
               read_en_L : in std_logic;
               read_pointer_out, write_pointer_out: out std_logic_vector(3 downto 0);
               write_en_out: out std_logic;
               credit_out: out std_logic;
               empty_out: out std_logic
               );
   end component;

  component FIFO_data_path_input_wire is
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
  end component;

  component FIFO_data is
      generic (
          DATA_WIDTH: integer := 32
      );
      port (  reset: in  std_logic;
              clk: in  std_logic;
              write_en: in  std_logic;
              RX : in  std_logic_vector(DATA_WIDTH-1 downto 0);
              read_pointer, write_pointer: in std_logic_vector(3 downto 0);
              Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
      );
  end component;

  begin

    FIFO_CONTROL_PART_inputs: FIFO_control_part_input_wire
    port map ( valid_in => valid_in,
               read_en_N => read_en_N, read_en_E =>read_en_E, read_en_W =>read_en_W, read_en_S =>read_en_S, read_en_L =>read_en_L,
                
               valid_in_out  => valid_in_out_sig,
               read_en_N_out => read_en_N_out_sig, read_en_E_out => read_en_E_out_sig, read_en_W_out => read_en_W_out_sig, 
               read_en_S_out => read_en_S_out_sig, read_en_L_out => read_en_L_out_sig               
             );

    FIFO_CONTROL_PART: FIFO_control
    port map ( reset => reset, clk => clk, valid_in => valid_in_out_sig,
               read_en_N => read_en_N_out_sig, read_en_E =>read_en_E_out_sig, read_en_W =>read_en_W_out_sig, 
               read_en_S =>read_en_S_out_sig, read_en_L =>read_en_L_out_sig,
               
               read_pointer_out => read_pointer, write_pointer_out => write_pointer, write_en_out => write_en,
               credit_out => credit_out, empty_out => empty_out);

    FIFO_DATA_PATH_inputs: FIFO_data_path_input_wire 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( write_en =>write_en, RX => RX,
               read_pointer => read_pointer, write_pointer => write_pointer, 
               
               write_en_out =>write_en_out_sig, RX_out => RX_out_sig,
               read_ptr_out => read_pointer_out_sig, write_ptr_out => write_pointer_out_sig
             );


    FIFO_DATA_PATH: FIFO_data 
    generic map ( DATA_WIDTH => DATA_WIDTH)
    port map ( reset => reset, clk => clk, write_en =>write_en_out_sig, RX => RX_out_sig,
               read_pointer => read_pointer_out_sig, write_pointer => write_pointer_out_sig, 

               Data_out => Data_out);


    read_pointer_out_out  <= read_pointer;
    write_pointer_out_out <= write_pointer;
    write_en_out_out      <= write_en;

end;