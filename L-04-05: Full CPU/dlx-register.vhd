-- Using packages from canvas files.
use work.dlx_types.all;
use work.bv_arithmetic.all;

entity dlx_register is
    generic(prop_delay: time := 10ns);
    port(
        in_val : in dlx_word;
        clock : in bit;
        out_val : out dlx_word
    );
end entity dlx_register;

architecture behavior of dlx_register is
begin
    dlx_register: process(in_val, clock) is
    begin
        -- If the clock is high
        if clock = '1' then
            -- Assign the input value to the output value
            out_val <= in_val after prop_delay;
        end if;
    end process dlx_register;
end architecture behavior;