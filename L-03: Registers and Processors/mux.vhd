-- Using packages from canvas files.
use work.dlx_types.all;
use work.bv_arithmetic.all;

entity mux is
    generic(prop_delay : time := 5ns);
    port(
        input_1 : in dlx_word; -- Input 1
        input_0 : in dlx_word; -- Input 0
        which   : in bit;      -- Which input to select
        output  : out dlx_word -- Output
    );
end entity mux;

architecture behavior of mux is
begin  
    mux: process(input_1, input_0, which) is
    begin
         -- If the which signal is 0
        if which = '0' then
            -- Copy input 0 to the output
            output <= input_0 after prop_delay;
         -- If the which signal is 1
        else
            -- Copy input 1 to the output
            output <= input_1 after prop_delay;
        end if;
    end process mux;
end architecture behavior;