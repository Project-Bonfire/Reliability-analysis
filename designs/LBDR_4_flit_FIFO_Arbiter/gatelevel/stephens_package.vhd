LIBRARY ieee;
  library std;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE ieee.math_real.ALL;
  USE std.textio.ALL;
 
 PACKAGE stephens_package IS
 function to_bstring(sl : std_logic) return string;
 function to_bstring(slv : std_logic_vector) return string;
 END PACKAGE;

PACKAGE BODY stephens_package IS
 function to_bstring(sl : std_logic) return string is
   variable sl_str_v : string(1 to 3);  -- std_logic image with quotes around
    begin
     sl_str_v := std_logic'image(sl);
   return "" & sl_str_v(2);  -- "" & character to get string
  end function;

  function to_bstring(slv : std_logic_vector) return string is
   alias    slv_norm : std_logic_vector(1 to slv'length) is slv;
    variable sl_str_v : string(1 to 1);  -- String of std_logic
    variable res_v    : string(1 to slv'length);
   begin
   for idx in slv_norm'range loop
    sl_str_v := to_bstring(slv_norm(idx));
    res_v(idx) := sl_str_v(1);
   end loop;
    return res_v;
  end function;
END PACKAGE BODY;
