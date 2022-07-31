setup () {
    load 'test/test_helper/bats-support/load'
    load 'test/test_helper/bats-assert/load'
    load 'test/test_helper/bats-file/load'
    cp test/key ./key
    key="./key"
    output="./marks"
    touch "$key"
}

teardown () {
    rm -f "$key"
}

@test "0 arguments" {
    run ./macchiato
    assert_failure
}

@test "1 argument" {
    run ./macchiato keyfile
    assert_failure
}

@test "no answer key" {
    [ -e "$key" ] && rm "$key"
    run ./macchiato "$key" file1 file2
    assert_failure
}

@test "Lots of arguments" {
    run ./macchiato $key file1 file2
    assert_success
}

@test "Plaintext" {
    run ./macchiato $key test/clean/student*
    for number in 1 2 3 4; do
        assert_file_contains marks "student${number} ${number}"
    done
}
