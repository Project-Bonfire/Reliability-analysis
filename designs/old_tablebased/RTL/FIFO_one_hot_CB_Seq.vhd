--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO_cb_seq is
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
end FIFO_cb_seq;

architecture behavior of FIFO_cb_seq is

begin

   process (clk, reset)begin
        if reset = '0' then
            read_pointer  <= "0001";
            write_pointer <= "0001";
            FIFO_MEM_1 <= (others=>'0');
            FIFO_MEM_2 <= (others=>'0');
            FIFO_MEM_3 <= (others=>'0');
            FIFO_MEM_4 <= (others=>'0');
            credit_out_FF <= '0';

        elsif clk'event and clk = '1' then
            write_pointer <= write_pointer_in;
            read_pointer  <=  read_pointer_in;
            FIFO_MEM_1 <= FIFO_MEM_1_enabled;
            FIFO_MEM_2 <= FIFO_MEM_2_enabled;
            FIFO_MEM_3 <= FIFO_MEM_3_enabled;
            FIFO_MEM_4 <= FIFO_MEM_4_enabled;
            credit_out_FF <= credit_out_FF_in;

        end if;
    end process;
end;
