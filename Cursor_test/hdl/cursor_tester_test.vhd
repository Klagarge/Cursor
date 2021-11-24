ARCHITECTURE test OF cursor_tester IS

  constant clockFrequency: real := 66.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  signal testMode_int: std_uLogic;

  constant buttonsPulseWidth : time := 100 us;

  constant pulsesPerTurn: integer := 2000;
  constant pwmReadBitNb: positive :=8;
  constant pwmLowpassAddBitNb: positive :=8;
  constant voltageToSpeedBitNb: positive := 8;
  signal side1Acc: unsigned(pwmReadBitNb+pwmLowpassAddBitNb-1 downto 0) := (others => '0');
  signal side2Acc: unsigned(pwmReadBitNb+pwmLowpassAddBitNb-1 downto 0) := (others => '0');
  signal side1M: unsigned(pwmReadBitNb-1 downto 0);
  signal side2M: unsigned(pwmReadBitNb-1 downto 0);
  signal position: signed(pwmReadBitNb+voltageToSpeedBitNb-1 downto 0) := (others => '0');
  signal stepCount: unsigned(1 downto 0);

BEGIN

  ------------------------------------------------------------------------------
  -- clock and reset
  --
  reset <= '1', '0' after 2*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after clockPeriod*9/10;


  ------------------------------------------------------------------------------
  -- test sequence
  --
  process
  begin

    testMode_int <= '1';

    restart <= '0';
    go1 <= '0';
    go2 <= '0';
    button4 <= '0';

    sensor1 <= '0';
    sensor2 <= '0';

    wait for 0.1 ms;
    
     ----------------------------------------------------------------------------
                                                    -- restart
    restart <= '1', '0' after buttonsPulseWidth;
    wait for 0.25 ms;
    sensor1 <= '1', '0' after buttonsPulseWidth;
    wait for 0.25 ms;

    ----------------------------------------------------------------------------
                                                  -- advance to first stop point
    go1 <= '1', '0' after buttonsPulseWidth;
    wait for 2 ms;

    ----------------------------------------------------------------------------
                                                 -- advance to second stop point
    go2 <= '1', '0' after buttonsPulseWidth;
    wait for 2 ms;

    ----------------------------------------------------------------------------
                                                  -- go back to first stop point
    go1 <= '1', '0' after buttonsPulseWidth;
    wait for 2 ms;

    ----------------------------------------------------------------------------
                                              -- back to start with sensor reset
    restart <= '1', '0' after buttonsPulseWidth;
    wait for 0.5 ms;
    sensor1 <= '1', '0' after buttonsPulseWidth;
    wait for 0.5 ms;

    ----------------------------------------------------------------------------
                                                 -- advance to second stop point
    go2 <= '1', '0' after buttonsPulseWidth;
    wait for 3 ms;

    ----------------------------------------------------------------------------
                                              -- back to start with counter stop
    restart <= '1', '0' after buttonsPulseWidth;
    wait for 2 ms;
    sensor1 <= '1', '0' after buttonsPulseWidth;
    wait for 1 ms;

    ----------------------------------------------------------------------------
                                                               -- quit test mode
    testMode_int <= '0';

    ----------------------------------------------------------------------------
                                                  -- advance to first stop point
    go1 <= '1', '0' after buttonsPulseWidth;
    wait for 2 ms;

    wait;
  end process;

  testMode <= testMode_int;

  ------------------------------------------------------------------------------
  -- PWM lowpass
  --
  process(sClock)
  begin
    if rising_edge(sClock) then
      if side1 = '1' then
        side1Acc <= side1Acc + 2**pwmReadBitNb-1 - shift_right(side1Acc, pwmLowpassAddBitNb);
      else
        side1Acc <= side1Acc - shift_right(side1Acc, pwmLowpassAddBitNb);
      end if;
      if side2 = '1' then
        side2Acc <= side2Acc + 2**pwmReadBitNb-1 - shift_right(side2Acc, pwmLowpassAddBitNb);
      else
        side2Acc <= side2Acc - shift_right(side2Acc, pwmLowpassAddBitNb);
      end if;
    end if;
  end process;

  side1M <= resize(shift_right(side1Acc, pwmLowpassAddBitNb), side1M'length);
  side2M <= resize(shift_right(side2Acc, pwmLowpassAddBitNb), side2M'length);

  ------------------------------------------------------------------------------
  -- motor feedback
  --
  count: process (sClock)
  begin
    if motorOn = '1' then
      if testMode_int = '0' then
        position <= position + to_integer(side1M) - to_integer(side2M);
      else
        position <= position + (to_integer(side1M) - to_integer(side2M)) * 5;
      end if;
    end if;
  end process count;

  stepCount <= resize(shift_right(unsigned(position), position'length-stepCount'length), stepCount'length);

  encoderA <= stepCount(1);
  encoderB <= not stepCount(1) xor stepCount(0);
  encoderI <= '1' when stepCount = pulsesPerTurn-1 else '0';

END ARCHITECTURE test;
