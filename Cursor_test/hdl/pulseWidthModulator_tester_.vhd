--
-- VHDL Architecture Cursor_test.pulseWidthModulator_tester.arch_name
--
-- Created:
--          by - Simon.UNKNOWN (PC-SDM)
--          at - 08:54:14 14.01.2022
--
-- using Mentor Graphics HDL Designer(TM) 2019.2 (Build 5)
--
ARCHITECTURE arch_name OF pulseWidthModulator_tester IS


  constant clockFrequency: real := 66.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal clock_int: std_ulogic := '0';

BEGIN

-----------------------------------------------------------------------------
                                                             -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  clock_int <= not clock_int after clockPeriod/2;
  clock <= transport clock_int after 9*clockPeriod/10;

  ------------------------------------------------------------------------------
  
END ARCHITECTURE arch_name;

