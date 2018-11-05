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
            Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end FIFO_credit_based;

architecture behavior of FIFO_credit_based is
   signal read_pointer, read_pointer_in,  write_pointer, write_pointer_in: std_logic_vector(3 downto 0);
   signal full, empty: std_logic;
   signal read_en, write_en: std_logic;

   signal FIFO_MEM_1, FIFO_MEM_1_in, FIFO_MEM_1_enabled : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal FIFO_MEM_2, FIFO_MEM_2_in, FIFO_MEM_2_enabled : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal FIFO_MEM_3, FIFO_MEM_3_in, FIFO_MEM_3_enabled : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal FIFO_MEM_4, FIFO_MEM_4_in, FIFO_MEM_4_enabled : std_logic_vector(DATA_WIDTH-1 downto 0);

   signal credit_out_FF, credit_out_FF_in: std_logic;

   component FIFO_cb_seq is
       generic (
           DATA_WIDTH: integer := 32
       );
       port (  reset: in  std_logic;
               clk: in  std_logic;

               credit_out_FF_in: in std_logic;
               FIFO_MEM_1_enabled : in std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_2_enabled : in std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_3_enabled : in std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_4_enabled : in std_logic_vector(DATA_WIDTH-1 downto 0);
               read_pointer_in,  write_pointer_in: in std_logic_vector(3 downto 0);

               credit_out_FF: out std_logic;
               FIFO_MEM_1 : out std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_2 : out std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_3 : out std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_4 : out std_logic_vector(DATA_WIDTH-1 downto 0);

               read_pointer,  write_pointer : out std_logic_vector(3 downto 0)
               );
   end component;

   component FIFO_CB_comb is
       generic (
           DATA_WIDTH: integer := 32
       );
       port (
               RX: in std_logic_vector(DATA_WIDTH-1 downto 0);
               valid_in: in std_logic;
               read_en_N : in std_logic;
               read_en_E : in std_logic;
               read_en_W : in std_logic;
               read_en_S : in std_logic;
               read_en_L : in std_logic;
               credit_out_FF: in std_logic;

               FIFO_MEM_1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_2 : in std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_3 : in std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_4 : in std_logic_vector(DATA_WIDTH-1 downto 0);
               read_pointer,  write_pointer: in std_logic_vector(3 downto 0);

               credit_out_FF_in: out std_logic;

               FIFO_MEM_1_enabled : out std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_2_enabled : out std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_3_enabled : out std_logic_vector(DATA_WIDTH-1 downto 0);
               FIFO_MEM_4_enabled : out std_logic_vector(DATA_WIDTH-1 downto 0);

               read_pointer_in,  write_pointer_in: out std_logic_vector(3 downto 0);

               empty_out: out std_logic;
               Data_out: out std_logic_vector(DATA_WIDTH-1 downto 0)
       );
   end component;

begin

  credit_out <= credit_out_FF;

  FIFO_seq: FIFO_cb_seq generic map (DATA_WIDTH  => DATA_WIDTH)
     PORT MAP (reset => reset,
               clk => clk,
               credit_out_FF_in => credit_out_FF_in,
               FIFO_MEM_1_enabled => FIFO_MEM_1_enabled,
               FIFO_MEM_2_enabled => FIFO_MEM_2_enabled,
               FIFO_MEM_3_enabled => FIFO_MEM_3_enabled,
               FIFO_MEM_4_enabled => FIFO_MEM_4_enabled,
               read_pointer_in => read_pointer_in,  write_pointer_in => write_pointer_in,
               credit_out_FF => credit_out_FF,
               FIFO_MEM_1 => FIFO_MEM_1,
               FIFO_MEM_2 => FIFO_MEM_2,
               FIFO_MEM_3 => FIFO_MEM_3,
               FIFO_MEM_4 => FIFO_MEM_4,
               read_pointer => read_pointer,  write_pointer => write_pointer
     );


  FIFO_comb: FIFO_CB_comb generic map (DATA_WIDTH  => DATA_WIDTH)
     PORT MAP (RX => RX, valid_in => valid_in,
               read_en_N => read_en_N,
               read_en_E => read_en_E,
               read_en_W => read_en_W,
               read_en_S => read_en_S,
               read_en_L => read_en_L,
               credit_out_FF => credit_out_FF,
               FIFO_MEM_1 => FIFO_MEM_1,
               FIFO_MEM_2 => FIFO_MEM_2,
               FIFO_MEM_3 => FIFO_MEM_3,
               FIFO_MEM_4 => FIFO_MEM_4,
               read_pointer =>  read_pointer,  write_pointer => write_pointer,
               credit_out_FF_in => credit_out_FF_in,
               FIFO_MEM_1_enabled => FIFO_MEM_1_enabled,
               FIFO_MEM_2_enabled => FIFO_MEM_2_enabled,
               FIFO_MEM_3_enabled => FIFO_MEM_3_enabled,
               FIFO_MEM_4_enabled => FIFO_MEM_4_enabled,
               read_pointer_in =>  read_pointer_in,  write_pointer_in => write_pointer_in,
               empty_out => empty_out,
               Data_out => Data_out

     );


end;
