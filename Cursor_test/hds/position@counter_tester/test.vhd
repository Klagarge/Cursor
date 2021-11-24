ARCHITECTURE test OF positionCounter_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';

  constant pulsesPerTurn: integer := 200;
  constant stepPeriodNb: positive := 16;
  signal stepEn: std_uLogic := '0';
  signal direction: std_uLogic;
  signal stepCount: unsigned(10 downto 0) := (others => '0');

BEGIN

  ------------------------------------------------------------------------------
  -- clock and reset
  --
  reset <= '1', '0' after clockPeriod/4;

  sClock <= not sClock after clockPeriod/2;
  clock <= sClock after clockPeriod/10;

  ------------------------------------------------------------------------------
  -- encoder signals
  --
  direction <= '1', '0' after 2000*clockPeriod;

  stepEn <= not stepEn after (stepPeriodNb/4)*clockPeriod;

  count: process (stepEn)
  begin
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
  end process count;

  encoderA <= stepCount(1);
  encoderB <= stepCount(1) xor stepCount(0);
  encoderI <= '1' when stepCount = pulsesPerTurn-1 else '0';

  ------------------------------------------------------------------------------
  -- control signals
  --
  clear <= '0',
           '1' after 100*clockPeriod,
           '0' after 101*clockPeriod;

END test;
