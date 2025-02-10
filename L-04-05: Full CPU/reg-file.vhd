-- Using packages from canvas files.
use work.dlx_types.all;
use work.bv_arithmetic.all;

entity reg_file is
    generic(prop_delay: time := 15ns);
    port(
        data_in      : in dlx_word;         -- Data input
        readnotwrite : in bit;              -- Read = 1, Write = 0
        clock        : in bit;              -- Clock signal
        data_out     : out dlx_word;        -- Data output
        reg_number   : in register_index    -- 5-bit register index
    );
end entity reg_file;

architecture behavior of reg_file is
    type reg_type is array (0 to 31) of dlx_word;
    signal registers : reg_type;
begin
    reg_file: process(data_in, readnotwrite, clock, reg_number) is
    begin
        -- If the clock is high
        if clock = '1' then
             -- If the readnotwrite signal is on READ
            if readnotwrite = '1' then 
                -- Assign register value to the output
                data_out <= registers(bv_to_integer(reg_number)) after 15 ns;
             -- If the readnotwrite signal is on WRITE
            else 
                -- Assign the input value to the register number
                registers(bv_to_integer(reg_number)) <= data_in after 15 ns;
            end if;
        end if;
    end process reg_file;
end architecture behavior;