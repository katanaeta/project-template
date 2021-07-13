#! /bin/bash

#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#
# PURPOSE:       Test suite for testing the project scaffolding after executing the SETUP_TEMPLATE script.
# TITLE:         Project Scaffolding tests
# AUTHOR:        Jose Gracia
# VERSION:       See in CHANGELOG.md
# NOTES:         This script is called by the TESTS_RUNNER.sh script. And it unit tests the newly generated scaffolding
#                generated by the SETUP_TEMPLATE script.
# BASH_VERSION:  5.1.4(1)-release (x86_64-pc-linux-gnu)
# LICENSE:       see in ../LICENSE (project root) or https://github.com/Josee9988/project-template/blob/master/LICENSE
# GITHUB:        https://github.com/Josee9988/
# REPOSITORY:    https://github.com/Josee9988/project-template
# ISSUES:        https://github.com/Josee9988/project-template/issues
# MAIL:          jgracia9988@gmail.com
#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#

TESTS_TRASH_DIR="tests/.ignore.tests_trash"
MAIL="FAKE_EMAIL_TESTS"
SCRIPT_OUTPUT="script_output.txt"

setUp() {
    cp -r * $TESTS_TRASH_DIR --copy-content 2>/dev/null || :
    cp -r .github/ $TESTS_TRASH_DIR --copy-contents
    cp -r bin/ $TESTS_TRASH_DIR --copy-contents
    cp .gitignore $TESTS_TRASH_DIR --copy-contents
    rm -r $TESTS_TRASH_DIR/tests/ 2>/dev/null || :
    rm -r $TESTS_TRASH_DIR/.git/ 2>/dev/null || :
    cd $TESTS_TRASH_DIR || exit
}

tearDown() {
    rm $SCRIPT_OUTPUT 2>/dev/null || :
    cd "../.." || exit
}

# TESTS
suite() {
    suite_addTest testHelp
    suite_addTest testHelpWithOtherArguments
}

testHelp() {
    expected_output="Script usage:"
    expected_output2="read the documentation before executing"
    expected_output3="User help"
    bash SETUP_TEMPLATE.sh -h >script_output.txt # run the setup script
    assertTrue " help output was not found" "grep -q \"$expected_output\" \"$SCRIPT_OUTPUT\""
    assertTrue " help output was not found" "grep -q \"$expected_output2\" \"$SCRIPT_OUTPUT\""
    assertTrue " help output was not found" "grep -q \"$expected_output3\" \"$SCRIPT_OUTPUT\""
}

testHelpWithOtherArguments() {
    expected_output="Script usage:"
    expected_output2="read the documentation before executing"
    expected_output3="User help"
    bash SETUP_TEMPLATE.sh --help --will_omit_commit_and_confirmation --project=aaa --type=bbb >script_output.txt # run the setup script
    assertTrue " help output was not found" "grep -q \"$expected_output\" \"$SCRIPT_OUTPUT\""
    assertTrue " help output was not found" "grep -q \"$expected_output2\" \"$SCRIPT_OUTPUT\""
    assertTrue " help output was not found" "grep -q \"$expected_output3\" \"$SCRIPT_OUTPUT\""
}

# Load and run shUnit2.
. tests/shunit2