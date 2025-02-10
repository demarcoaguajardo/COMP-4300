-- Using packages from canvas files.
use work.dlx_types.all;
use work.bv_arithmetic.all;

entity pcplusone is
    generic(prop_delay : time := 5ns);
    port(
        input   : in dlx_word; -- Input
        clock   : in bit;      -- Clock signal
        output  : out dlx_word -- Output
    );
end entity pcplusone;

architecture behavior of pcplusone is
begin
    pcplusone: process(input, clock) is
    begin  
         -- If the clock signal is high
        if clock = '1' then
            -- Increment the input value by 1
            output <= natural_to_bv(bv_to_natural(input) + 1, input'length) after prop_delay;
        end if;
    end process pcplusone;
end architecture behavior;