ARCHITECTURE test OF pulseWidthModulator_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';

  constant enPeriodNb: positive := 3;
  signal sEn: std_uLogic := '0';

BEGIN

  ------------------------------------------------------------------------------
  -- clock and reset
  --
  reset <= '1', '0' after clockPeriod/4;

  sClock <= not sClock after clockPeriod/2;
  clock <= sClock after clockPeriod/10;

  ------------------------------------------------------------------------------
  -- control signals
  --
  amplitude <= to_unsigned( 64, amplitude'length),
               to_unsigned(128, amplitude'length) after 10*256*enPeriodNb*clockPeriod,
               to_unsigned(192, amplitude'length) after 20*256*enPeriodNb*clockPeriod;

  sEn <= '1' after (enPeriodNb-1)*clockPeriod when sEn = '0' else '0' after clockPeriod;
  en <= sEn;

END test;
