#!/usr/bin/env bats

@test "Perl is installed" {
    run which perl
    [ "$status" -eq 0 ]
}
