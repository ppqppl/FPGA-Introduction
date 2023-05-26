<project xmlns="com.autoesl.autopilot.project" top="flash_led" name="HLS">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" optimizeCompile="true" clean="true" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="../code/HLS_HelloWorld_tb.cpp" sc="0" tb="1" cflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="HLS/code/HLS_HelloWorld.h" sc="0" tb="false" cflags="" blackbox="false"/>
        <file name="HLS/code/HLS_HelloWorld.cpp" sc="0" tb="false" cflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="solution1" status="active"/>
    </solutions>
</project>

