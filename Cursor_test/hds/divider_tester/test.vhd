ARCHITECTURE test OF divider_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';

BEGIN

  reset <= '1', '0' after clockPeriod/4;

  sClock <= not sClock after clockPeriod/2;
  clock <= sClock after clockPeriod/10;

  testMode <= '1', '0' after 10000*clockPeriod;

  start <=  '0',
              '1' after 210 us,
              '0' after 210 us + clockPeriod,
              '1' after 2.1 ms,
              '0' after 2.1 ms + clockPeriod;

END test;
