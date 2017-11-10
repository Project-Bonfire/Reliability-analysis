--Copyright (C) 2016 Siavoosh Payandeh Azad

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO_CB_comb is
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
end FIFO_CB_comb;

architecture behavior of FIFO_CB_comb is
   signal full, empty: std_logic;
   signal read_en, write_en: std_logic;

   signal FIFO_MEM_1_in : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal FIFO_MEM_2_in : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal FIFO_MEM_3_in : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal FIFO_MEM_4_in : std_logic_vector(DATA_WIDTH-1 downto 0);

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


 -- anything below here is pure combinational
  read_en <= (read_en_N or read_en_E or read_en_W or read_en_S or read_en_L) and not empty;
  empty_out <= empty;


  -- generating the credit out flip flop inputs
  process(read_en, credit_out_FF)begin
      if read_en = '1' then
        credit_out_FF_in <= '1';
      else
        credit_out_FF_in <= '0';
      end if;
  end process;

   -- handeling the write_en in the most stupid way!
   process (write_en,FIFO_MEM_1_in, FIFO_MEM_2_in, FIFO_MEM_3_in, FIFO_MEM_4_in,
            FIFO_MEM_1, FIFO_MEM_2, FIFO_MEM_3, FIFO_MEM_4)begin
     if write_en = '1' then
       FIFO_MEM_1_enabled <= FIFO_MEM_1_in;
       FIFO_MEM_2_enabled <= FIFO_MEM_2_in;
       FIFO_MEM_3_enabled <= FIFO_MEM_3_in;
       FIFO_MEM_4_enabled <= FIFO_MEM_4_in;
     else
       FIFO_MEM_1_enabled <= FIFO_MEM_1;
       FIFO_MEM_2_enabled <= FIFO_MEM_2;
       FIFO_MEM_3_enabled <= FIFO_MEM_3;
       FIFO_MEM_4_enabled <= FIFO_MEM_4;
     end if;
   end process;

   -- writing into the memory
   process(RX, write_pointer, FIFO_MEM_1, FIFO_MEM_2, FIFO_MEM_3, FIFO_MEM_4)begin
      case( write_pointer ) is
          when "0001" => FIFO_MEM_1_in <= RX;         FIFO_MEM_2_in <= FIFO_MEM_2; FIFO_MEM_3_in <= FIFO_MEM_3; FIFO_MEM_4_in <= FIFO_MEM_4;
          when "0010" => FIFO_MEM_1_in <= FIFO_MEM_1; FIFO_MEM_2_in <= RX;         FIFO_MEM_3_in <= FIFO_MEM_3; FIFO_MEM_4_in <= FIFO_MEM_4;
          when "0100" => FIFO_MEM_1_in <= FIFO_MEM_1; FIFO_MEM_2_in <= FIFO_MEM_2; FIFO_MEM_3_in <= RX;         FIFO_MEM_4_in <= FIFO_MEM_4;
          when "1000" => FIFO_MEM_1_in <= FIFO_MEM_1; FIFO_MEM_2_in <= FIFO_MEM_2; FIFO_MEM_3_in <= FIFO_MEM_3; FIFO_MEM_4_in <= RX;
          when others => FIFO_MEM_1_in <= FIFO_MEM_1; FIFO_MEM_2_in <= FIFO_MEM_2; FIFO_MEM_3_in <= FIFO_MEM_3; FIFO_MEM_4_in <= FIFO_MEM_4;
      end case ;
   end process;


  -- reading from the memory
  process(read_pointer, FIFO_MEM_1, FIFO_MEM_2, FIFO_MEM_3, FIFO_MEM_4)begin
    case( read_pointer ) is
        when "0001" => Data_out <= FIFO_MEM_1;
        when "0010" => Data_out <= FIFO_MEM_2;
        when "0100" => Data_out <= FIFO_MEM_3;
        when "1000" => Data_out <= FIFO_MEM_4;
        when others => Data_out <= FIFO_MEM_1;
    end case ;
  end process;

  -- generating the write pointer
  process(write_en, write_pointer)begin
    if write_en = '1'then
       write_pointer_in <= write_pointer(2 downto 0)&write_pointer(3);
    else
       write_pointer_in <= write_pointer;
    end if;
  end process;

  -- generating the read pointer
  process(read_en, empty, read_pointer)begin
       if (read_en = '1' and empty = '0') then
           read_pointer_in <= read_pointer(2 downto 0)&read_pointer(3);
       else
           read_pointer_in <= read_pointer;
       end if;
  end process;

  -- generating the write eneable signal
  process(full, valid_in) begin
     if valid_in = '1' and full ='0' then
         write_en <= '1';
     else
         write_en <= '0';
     end if;
  end process;

  -- generating empty and full signals
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
