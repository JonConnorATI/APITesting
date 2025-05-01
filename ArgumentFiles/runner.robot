--name API Testing
--exclude donotrun
--exclude firefox
--exclude edge
--xunit API_TEST-xunit.xml
# --listener time_logger.py
--outputdir reports
--output API_TEST-xml
--log API_TEST-log
--report API_TEST-report
# --variable browser:chromium
--variable channel:None
--variable environment:user01
--loglevel TRACE
--variable headless:false
--debugfile debug_gc.log
Robot_Tests/API_methods.robot
