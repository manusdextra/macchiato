setup () {
    load 'test/test_helper/bats-support/load'
    load 'test/test_helper/bats-assert/load'
    key="./key"
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
