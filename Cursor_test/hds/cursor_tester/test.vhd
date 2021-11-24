ARCHITECTURE test OF cursor_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';

  constant pulsesPerTurn: integer := 200;
  constant stepPeriodNb: positive := 8;
  signal stepEn: std_uLogic := '0';
  signal direction: std_uLogic;
  signal turning: std_uLogic;
  signal stepCount: unsigned(10 downto 0) := (others => '0');

BEGIN

  ------------------------------------------------------------------------------
  -- clock and reset
  --
  reset <= '1', '0' after clockPeriod/4;

  sClock <= not sClock after clockPeriod/2;
  clock <= sClock after clockPeriod/10;


  ------------------------------------------------------------------------------
  -- test sequence
  --
  process
  begin

    testMode <= '1';

    restart <= '0';
    go1 <= '0';
    go2 <= '0';
    setPoint <= '0';

    sensor1 <= '0';
    sensor2 <= '0';

    wait for 1 us;

    ----------------------------------------------------------------------------
                                                  -- advance to first stop point
    go1 <= '1', '0' after 1 us;
    wait for 4 ms;

    ----------------------------------------------------------------------------
                                                 -- advance to second stop point
    go2 <= '1', '0' after 1 us;
    wait for 4 ms;

    ----------------------------------------------------------------------------
                                              -- back to start with sensor reset
    restart <= '1', '0' after 1 us;
    wait for 0.5 ms;
    sensor1 <= '1', '0' after 1 us;
    wait for 0.5 ms;

    ----------------------------------------------------------------------------
                                                 -- advance to second stop point
    go2 <= '1', '0' after 1 us;
    wait for 7 ms;

    ----------------------------------------------------------------------------
                                                  -- go back to first stop point
    go1 <= '1', '0' after 1 us;
    wait for 4 ms;

    ----------------------------------------------------------------------------
                                              -- back to start with counter stop
    restart <= '1', '0' after 1 us;
    wait for 4 ms;
    sensor1 <= '1', '0' after 1 us;
    wait for 1 ms;

    wait;
  end process;

  ------------------------------------------------------------------------------
  -- motor feedback
  --
  turning <= motorOn;

  findDirection: process(side1, side2)
  begin
    if (side1 = '1') and (side2 = '0') then
      direction <= '1';
    elsif (side1 = '0') and (side2 = '1') then
      direction <= '0';
    end if;
  end process findDirection;

  stepEn <= not stepEn after (stepPeriodNb/4)*clockPeriod;

  count: process (stepEn)
  begin
    if turning = '1' then
      if direction = '1' then
        if stepCount < pulsesPerTurn-1 then
          stepCount <= stepCount + 1;
        else
          stepCount <= to_unsigned(0, stepCount'length);
        end if;
      else
        if stepCount > 0  then
          stepCount <= stepCount - 1;
        else
          stepCount <= to_unsigned(pulsesPerTurn-1, stepCount'length);
        end if;
      end if;
    end if;
  end process count;

  encoderA <= stepCount(1);
  encoderB <= not stepCount(1) xor stepCount(0);
  encoderI <= '1' when stepCount = pulsesPerTurn-1 else '0';

END test;
