entity twobitcounter is
    generic(prop_delay: Time := 10 ns);
    port(
        increment: in bit;
        count: out bit_vector(1 downto 0)
    );
end entity twobitcounter;

architecture behavior of twobitcounter is
    signal state: bit_vector(1 downto 0) := "00"; 
    signal increment_delayed: bit := '0';  -- To detect falling edge of increment
begin
    process(increment)
    begin
        -- Update delayed increment signal with a delay
        increment_delayed <= increment after prop_delay;

        -- Detect the falling edge of increment
        if increment = '0' and increment_delayed = '1' then
            -- Increment counter based on current state
            if state = "00" then
                state <= "01";
            elsif state = "01" then 
                state <= "10";
            elsif state = "10" then
                state <= "11";
            else -- state = "11"
                state <= "00"; -- Wraps back around
            end if;
        end if;

        -- Update the count
        count <= state;
    end process;
end architecture behavior;