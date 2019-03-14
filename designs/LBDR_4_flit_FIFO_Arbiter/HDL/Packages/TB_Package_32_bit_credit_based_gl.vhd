--Copyright (C) 2017 Siavoosh Payandeh Azad and Thilo Kogge

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
 use ieee.math_real.all;
 use std.textio.all;
 use ieee.std_logic_misc.all;

package TB_Package is
  function Header_gen(source, destination: integer ) return std_logic_vector ;

  function Body_1_gen(Packet_length, packet_id: integer ) return std_logic_vector ;
  function Body_gen(Data: integer ) return std_logic_vector ;

  function Tail_gen(Packet_length, Data: integer ) return std_logic_vector ;

  procedure credit_counter_control(signal clk: in std_logic; 
                                 signal credit_in: in std_logic; signal valid_out: in std_logic; 
                                 signal credit_counter_out: out std_logic_vector(1 downto 0));
  procedure gen_random_packet(filename,scenariofile: in string;
                      network_size, source: in integer;
                      finish_time: in time; signal clk: in std_logic;
                      signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic; 
                      signal port_in: out std_logic_vector);
  procedure get_packet(filename: in string;
                  DATA_WIDTH, initial_delay, Node_ID: in integer; signal clk: in std_logic; 
                     signal credit_out: out std_logic; signal valid_in: in std_logic; signal port_in: in std_logic_vector);
end TB_Package;

package body TB_Package is
  constant Header_type : std_logic_vector := "001";
  constant Body_type : std_logic_vector := "010";
  constant Tail_type : std_logic_vector := "100";

  function Header_gen(source, destination: integer)
              return std_logic_vector is
    	variable Header_flit: std_logic_vector (31 downto 0);
    	begin
    	Header_flit := Header_type &  std_logic_vector(to_unsigned(source, 14)) &
                     std_logic_vector(to_unsigned(destination, 14))  & XOR_REDUCE(Header_type &  std_logic_vector(to_unsigned(source, 14)) &
                     std_logic_vector(to_unsigned(destination, 14)));
    return Header_flit;
  end Header_gen;

  function Body_1_gen(Packet_length, packet_id: integer)
                return std_logic_vector is
    variable Body_flit: std_logic_vector (31 downto 0);
    begin
    Body_flit := Body_type &  std_logic_vector(to_unsigned(Packet_length, 14))&  std_logic_vector(to_unsigned(packet_id, 14)) &
                 XOR_REDUCE(Body_type &  std_logic_vector(to_unsigned(Packet_length, 14))&  std_logic_vector(to_unsigned(packet_id, 14)));
    return Body_flit;
  end Body_1_gen;


  function Body_gen(Data: integer)
                return std_logic_vector is
    variable Body_flit: std_logic_vector (31 downto 0);
    begin
    Body_flit := Body_type &  std_logic_vector(to_unsigned(Data, 28)) & XOR_REDUCE(Body_type & std_logic_vector(to_unsigned(Data, 28)));
    return Body_flit;
  end Body_gen;


  function Tail_gen(Packet_length, Data: integer)
                return std_logic_vector is
    variable Tail_flit: std_logic_vector (31 downto 0);
    begin
    Tail_flit := Tail_type &  std_logic_vector(to_unsigned(Data, 28)) & XOR_REDUCE(Tail_type & std_logic_vector(to_unsigned(Data, 28)));
    return Tail_flit;
  end Tail_gen;

  procedure credit_counter_control(signal clk: in std_logic; 
                                   signal credit_in: in std_logic; signal valid_out: in std_logic; 
                                   signal credit_counter_out: out std_logic_vector(1 downto 0)) is

    variable credit_counter: std_logic_vector (1 downto 0);

    begin
    credit_counter := "11";
    
    while true loop
      credit_counter_out<= credit_counter;
      wait until clk'event and clk ='1';
      if valid_out = '1' and credit_in ='1' then 
        credit_counter := credit_counter; 
      elsif credit_in = '1' then
        credit_counter := credit_counter + 1; 
      elsif valid_out = '1' and  credit_counter > 0 then
        credit_counter := credit_counter - 1; 
      else
        credit_counter := credit_counter; 
      end if;
    end loop;
  end credit_counter_control;

  procedure gen_random_packet(filename,scenariofile: in string;
    network_size, source: in integer;
                      finish_time: in time; signal clk: in std_logic;
                      signal credit_counter_in: in std_logic_vector(1 downto 0); signal valid_out: out std_logic; 
                      signal port_in: out std_logic_vector) is
    variable LINEVARIABLE : line; 
    file VEC_FILE : text is out filename;
    variable destination_id: integer;
    variable id_counter, Packet_length, linetmp: integer:= 0;
    variable starting_time : time;
    variable credit_counter: std_logic_vector (1 downto 0);
    variable x,y :integer ;
    variable v_ILINE : line; --the input line from the scn file
    variable v_SPACE     : character;
    variable body_data : std_logic_vector (27 downto 0);
    file scenario : text;--the opened scenario file
    begin
    file_open(scenario, scenariofile,  read_mode);
     
    valid_out <= '0';
    port_in <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
    wait until clk'event and clk ='1';
    for i in 0 to 30 loop --we had always an inital delay. keep this for safety.
      wait until clk'event and clk ='1';
    end loop;
    port_in <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" ;
    --ignore first 2 lines
    readline(scenario, v_ILINE);
    readline(scenario, v_ILINE);

    while true loop
    
      if not endfile(scenario) then 
        
        readline(scenario, v_ILINE);
        read(v_ILINE, starting_time);  --starting time for the next package      
        read(v_ILINE, v_SPACE);           -- read in the space character
        read(v_ILINE, linetmp);
        if source /= linetmp then --if the line is not for us, skip         
          next;
        end if;
        read(v_ILINE, v_SPACE);           -- read in the space character
        read(v_ILINE, destination_id);
        read(v_ILINE, v_SPACE);           -- read in the space character
        read(v_ILINE, Packet_length);
      else
        port_in <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" ;
        wait; --i am finished
      end if;  
      
      -- wait until its time to send
      while starting_time > now loop
          wait until clk'event and clk ='0';
      end loop;

      valid_out <= '0';
      while credit_counter_in = 0 loop
        wait until clk'event and clk ='0';
      end loop;

      -- generating the packet id
      id_counter := id_counter + 1;
      if id_counter = 16384 then
          id_counter := 0;
      end if;

      --------------------------------------
      wait until clk'event and clk ='0'; -- On negative edge of clk (for syncing purposes)
      port_in <= Header_gen(source, destination_id); -- Generating the header flit of the packet (All packets have a header flit)!
      valid_out <= '1';
      write(LINEVARIABLE, "type:header;time:" & time'image(now) & ";currentrouter:" &integer'image(source) &";from_node:" & integer'image(source) & ";to_node:" & integer'image(destination_id) & ";length:-1;id:-1;flitno:0");
      writeline(VEC_FILE, LINEVARIABLE);
      wait until clk'event and clk ='0';

      for I in 0 to Packet_length-3 loop  
            -- The reason for -3 is that we have packet length of Packet_length, now if you exclude header and tail
            -- it would be Packet_length-2 to enumerate them, you can count from 0 to Packet_length-3. 
            if credit_counter_in = "00" then 
             valid_out <= '0'; 
             -- Wait until next router/NI has at least enough space for one flit in its input FIFO
             wait until credit_counter_in'event and credit_counter_in > 0; 
             wait until clk'event and clk ='0';
            end if;

            body_data := std_logic_vector(to_unsigned(source,4)) &
               std_logic_vector(to_unsigned(destination_id,4)) &
               std_logic_vector(to_unsigned( Packet_length,5)) & 
               std_logic_vector(to_unsigned(id_counter,10)) & std_logic_vector(to_unsigned(0,5));

            -- Each packet can have no body flits or one or more than body flits.
            if I = 0 then
              port_in <= Body_1_gen(Packet_length, id_counter);
              write(LINEVARIABLE, "type:body1;time:" & time'image(now) & ";currentrouter:" & integer'image(source) &";from_node:" & integer'image(source) & ";to_node:" & integer'image(destination_id) & ";length:"& integer'image(Packet_length)  & ";id:"& integer'image(id_counter) &  ";flitno:" & integer'image(I+1));
              writeline(VEC_FILE, LINEVARIABLE);   
            else
              

              port_in <= Body_gen(to_integer(unsigned(body_data(27 downto 0))));
              write(LINEVARIABLE, "type:body;time:" & time'image(now) & ";currentrouter:" & integer'image(source) &";from_node:" & integer'image(source) & ";to_node:" & integer'image(destination_id) & ";length:"& integer'image(Packet_length)  & ";id:"& integer'image(id_counter) &  ";flitno:" & integer'image(I+1));
              writeline(VEC_FILE, LINEVARIABLE);
            end if;
            valid_out <= '1';

             wait until clk'event and clk ='0';
      end loop;

      if credit_counter_in = "00" then 
             valid_out <= '0'; 
             -- Wait until next router/NI has at least enough space for one flit in its input FIFO
             wait until credit_counter_in'event and credit_counter_in > 0; 
             wait until clk'event and clk ='0';
      end if;

      -- Close the packet with a tail flit (All packets have one tail flit)!
      port_in <= Tail_gen(Packet_length, to_integer(unsigned(body_data(27 downto 0)))); 
      valid_out <= '1';
      write(LINEVARIABLE, "type:tail;time:" & time'image(now) & ";currentrouter:" &integer'image(source) &";from_node:" & integer'image(source) & ";to_node:" & integer'image(destination_id) & ";length:"& integer'image(Packet_length)  & ";id:"& integer'image(id_counter) &  ";flitno:" & integer'image(Packet_length-1));
      writeline(VEC_FILE, LINEVARIABLE);
      wait until clk'event and clk ='0';

      valid_out <= '0';
      port_in <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ; -- TODO ??
      port_in <= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" ;
      
      
    end loop; 
  end gen_random_packet;

  procedure get_packet(filename: in string;
  DATA_WIDTH, initial_delay, Node_ID: in integer; signal clk: in std_logic; 
                       signal credit_out: out std_logic; signal valid_in: in std_logic; signal port_in: in std_logic_vector) is
  -- initial_delay: waits for this number of clock cycles before sending the packet!
    variable source_node, destination_node, P_length, packet_id, counter: integer;
    variable parity_failed : boolean;
    variable LINEVARIABLE : line; 
    variable body_src,body_dest,body_packet_length, body_packetid, body_checksum:integer;
     file VEC_FILE : text is out filename;
     begin
     credit_out <= '1';
     counter := 0;
     while true loop
         
         wait until clk'event and clk ='1';
        
         if valid_in = '1' then
             parity_failed := XOR_REDUCE(port_in(DATA_WIDTH-1 downto 1)) /= port_in(0);
              if (port_in(DATA_WIDTH-1 downto DATA_WIDTH-3) = "001") then
                counter := 1; 
                source_node := to_integer(unsigned(port_in(28 downto 15)));
                destination_node := to_integer(unsigned(port_in(14 downto 1)));
                write(LINEVARIABLE, "type:header;time:" & time'image(now) & ";currentrouter:" &integer'image(Node_ID) &";from_node:" & integer'image(source_node) & ";to_node:" & integer'image(destination_node) & ";length:-1;id:-1;flitno:0;parity_failed:"&boolean'image(parity_failed));
                writeline(VEC_FILE, LINEVARIABLE);
            end if;  
            body_src := to_integer(unsigned(port_in(28 downto 25)));
            body_dest := to_integer(unsigned(port_in(24 downto 21)));
            body_packet_length := to_integer(unsigned(port_in(20 downto 16)));
            body_packetid := to_integer(unsigned(port_in(15 downto 6)));
            body_checksum := to_integer(unsigned(port_in(5 downto 1)));
            if  (port_in(DATA_WIDTH-1 downto DATA_WIDTH-3) = "010") then
               if counter = 1 then
                  P_length := to_integer(unsigned(port_in(28 downto 15)));
                  packet_id := to_integer(unsigned(port_in(14 downto 1)));
                  write(LINEVARIABLE, "type:body1;time:" & time'image(now) &
                   ";currentrouter:" &integer'image(Node_ID) &";from_node:" &
                    integer'image(source_node) & ";to_node:" & integer'image(destination_node) &
                     ";length:"& integer'image(P_length)  & ";id:"& integer'image(packet_id)&
                       ";flitno:" & integer'image(counter)&";parity_failed:"&boolean'image(parity_failed)
                       );
                  writeline(VEC_FILE, LINEVARIABLE);               
               else
                  write(LINEVARIABLE, "type:body;time:" & time'image(now) &
                   ";currentrouter:" &integer'image(Node_ID) &
                   ";from_node:" & integer'image(source_node) &
                    ";to_node:" & integer'image(destination_node) &
                     ";length:"& integer'image(P_length)  & ";id:"&
                      integer'image(packet_id)&  ";flitno:" &
                       integer'image(counter)&";parity_failed:"&boolean'image(parity_failed)&
                       ";body_src:"& integer'image(body_src)& 
                       ";body_dest:"& integer'image(body_dest)& 
                       ";body_packet_length:"& integer'image(body_packet_length)& 
                       ";body_packetid:"& integer'image(body_packetid)& 
                       ";body_checksum:"& integer'image(body_checksum));
                  writeline(VEC_FILE, LINEVARIABLE);               
               end if;
               counter := counter+1; 
            end if;
            if (port_in(DATA_WIDTH-1 downto DATA_WIDTH-3) = "100") then 
                counter := counter+1; 
                write(LINEVARIABLE, "type:tail;time:" & time'image(now) &
                 ";currentrouter:" &integer'image(Node_ID) &
                 ";from_node:" & integer'image(source_node) & 
                 ";to_node:" & integer'image(destination_node) &
                  ";length:"& integer'image(P_length)  &
                   ";id:"& integer'image(packet_id) &
                     ";flitno:" & integer'image(counter)&
                     ";parity_failed:"&boolean'image(parity_failed) &
                       ";body_src:"& integer'image(body_src)& 
                       ";body_dest:"& integer'image(body_dest)& 
                       ";body_packet_length:"& integer'image(body_packet_length)& 
                       ";body_packetid:"& integer'image(body_packetid)& 
                       ";body_checksum:"& integer'image(body_checksum));
                writeline(VEC_FILE, LINEVARIABLE);
               counter := 0;
            end if;
         end if;

     end loop;
  end get_packet;

end TB_Package;
