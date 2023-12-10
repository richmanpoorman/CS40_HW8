 #! /bin/sh
shopt -s nullglob
TEST_OUTPUT="Test/Output/"
TEST_INPUT="Test/Input/"
NUM_RANDOM_INSTRUCTIONS=1000000

touch $TEST_INPUT"randomInput.test"
random-calc40 $NUM_RANDOM_INSTRUCTIONS > $TEST_INPUT"randomInput.test"

TESTS=($(ls $TEST_INPUT*.test))

touch calc40.um
sh compile.sh

time calc40-test calc40.um $NUM_RANDOM_INSTRUCTIONS



for testFull in "${TESTS[@]}"; do
        testNoPrefix=${testFull#$TEST_INPUT}
        test=${testNoPrefix%".test"}
        echo "Test: "$test

        touch $TEST_OUTPUT$test.testOut
        touch $TEST_OUTPUT$test.calc40TestsOut
        
        um calc40.um < $TEST_INPUT$test.test > $TEST_OUTPUT$test.testOut
        calc40 < $TEST_INPUT$test.test > $TEST_OUTPUT$test.calc40TestsOut

        DIFF=$(diff $TEST_OUTPUT$test.testOut \
                    $TEST_OUTPUT$test.calc40TestsOut)
        if [ "$DIFF" != "" ]; then 
                echo "    TEST FAILED: "
                echo "        DIFF: "
                echo $DIFF
                echo "        OUR FILE: "
                cat -v $TEST_OUTPUT$test.testOut
                echo "        THEIR FILE: "
                cat -v $TEST_OUTPUT$test.calc40TestsOut
        else 
                echo "    TEST PASSED:"
                # cat -v $TEST_OUTPUT$test.testOut 
                echo
        fi
        rm $TEST_OUTPUT$test.calc40TestsOut
done 

