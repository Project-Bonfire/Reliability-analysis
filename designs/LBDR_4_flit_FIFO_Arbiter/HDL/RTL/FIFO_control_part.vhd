--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO_control is
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
end FIFO_control;

architecture behavior of FIFO_control is
   signal read_pointer, read_pointer_in,  write_pointer, write_pointer_in: std_logic_vector(3 downto 0);
   signal full, empty: std_logic;
   signal read_en, write_en: std_logic;




begin
 --------------------------------------------------------------------------------------------
--                           block diagram of the FIFO!


 --------------------------------------------------------------------------------------------
--  circular buffer structure
--                                   <--- WriteP
--              ---------------------------------
--              |   3   |   2   |   1   |   0   |
--              ---------------------------------
--                                   <--- readP
 --------------------------------------------------------------------------------------------

   process (clk, reset)begin
        if reset = '0' then
            read_pointer  <= "0001";
            write_pointer <= "0001";

            credit_out <= '0';

        elsif clk'event and clk = '1' then
            write_pointer <= write_pointer_in;
            read_pointer  <=  read_pointer_in;
            credit_out <= '0';

            if read_en = '1' then
              credit_out <= '1';
            end if;
        end if;
    end process;

 -- anything below here is pure combinational

   -- combinatorial part

   read_pointer_out <= read_pointer;
   write_pointer_out <= write_pointer;

  read_en <= (read_en_N or read_en_E or read_en_W or read_en_S or read_en_L) and not empty;
  write_en_out <= write_en;
  empty_out <= empty;


  process(write_en, write_pointer)begin
    if write_en = '1'then
       write_pointer_in <= write_pointer(2 downto 0)&write_pointer(3);
    else
       write_pointer_in <= write_pointer;
    end if;
  end process;

  process(read_en, empty, read_pointer)begin
       if (read_en = '1' and empty = '0') then
           read_pointer_in <= read_pointer(2 downto 0)&read_pointer(3);
       else
           read_pointer_in <= read_pointer;
       end if;
  end process;

  process(full, valid_in) begin
     if valid_in = '1' and full ='0' then
         write_en <= '1';
     else
         write_en <= '0';
     end if;
  end process;

  process(write_pointer, read_pointer) begin
      if read_pointer = write_pointer  then
              empty <= '1';
      else
              empty <= '0';
      end if;
      --      if write_pointer = read_pointer>>1 then
      if write_pointer = read_pointer(0)&read_pointer(3 downto 1) then
              full <= '1';
      else
              full <= '0';
      end if;
  end process;

end;
